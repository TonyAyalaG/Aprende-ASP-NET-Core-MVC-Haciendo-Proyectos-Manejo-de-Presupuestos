﻿using Dapper;
using ManejoPresupuesto.Models;
using Microsoft.Data.SqlClient;

namespace ManejoPresupuesto.Servicios
{
    public interface IRepositorioTiposCuentas
    {
        Task Actualizar(TipoCuenta tipoCuenta);
        Task Crear(TipoCuenta tipoCuenta);
        Task<bool> Existe(string nombre, int usuarioId);
        Task<TipoCuenta> ObetenerPorId(int id, int usuarioId);
        Task<IEnumerable<TipoCuenta>> Obtener(int usuarioId);
    }
    public class RepositorioTiposCuentas: IRepositorioTiposCuentas
    {
        private readonly string connectionString;  
        public RepositorioTiposCuentas(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("DefaultConnection");
                
        }
        public async Task Crear(TipoCuenta tipoCuenta)
        {
            using var connection = new SqlConnection(connectionString);
            var id = await connection.QuerySingleAsync<int>(@"
                                                    insert into TiposCuentas (Nombre, UsuarioId, Orden)
                                                    values (@Nombre, @UsuarioId,0); SELECT SCOPE_IDENTITY();",tipoCuenta);
            tipoCuenta.Id = id;
        }
        public async Task<bool> Existe(string nombre, int usuarioId)
        {
            using var connection = new SqlConnection(connectionString);
            var existe = await connection.QueryFirstOrDefaultAsync<int>(@"
                Select 1 from TiposCuentas Where Nombre = @Nombre 
                and UsuarioId=@UsuarioId", 
                new {nombre, usuarioId});
            return existe == 1;
        }
        public async Task<IEnumerable<TipoCuenta>> Obtener (int usuarioId)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryAsync<TipoCuenta>(@"Select Id, Nombre, Orden From TiposCuentas Where UsuarioId = @UsuarioId", new {usuarioId});
        }

        public async Task Actualizar( TipoCuenta tipoCuenta)
        {
            using var connection = new SqlConnection(connectionString);
            await connection.ExecuteAsync(@"Update TiposCuentas 
                                            Set Nombre = @Nombre  Where Id = @Id",tipoCuenta);
        }

        public async Task<TipoCuenta> ObetenerPorId(int id, int usuarioId)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryFirstOrDefaultAsync<TipoCuenta>(@"
                                                                SELECT Id, Nombre, Orden
                                                                FROM TiposCuentas
                                                                WHERE Id = @Id AND UsuarioId = @UsuarioId", new { id, usuarioId });
        }


    }
}
