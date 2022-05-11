﻿using Dapper;
using ManejoPresupuesto.Models;
using Microsoft.Data.SqlClient;

namespace ManejoPresupuesto.Servicios
{
    public interface IRepositorioTiposCuentas
    {
        Task Actualizar(TipoCuenta tipoCuenta);
        Task Borrar(int id);
        Task Crear(TipoCuenta tipoCuenta);
        Task<bool> Existe(string nombre, int usuarioId);
        Task<TipoCuenta> ObtenerPorId(int id, int usuarioId);
        Task<IEnumerable<TipoCuenta>> Obtener(int usuarioId);
        Task Ordenar(IEnumerable<TipoCuenta> tipoCuentasOrdenados);
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
            var id = await connection.QuerySingleAsync<int>("TiposCuentas_Insertar", 
                                                                                    new {usuarioId = tipoCuenta.UsuarioId,
                                                                                    nombre = tipoCuenta.Nombre},
                                                                                    commandType: System.Data.CommandType.StoredProcedure);
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
            return await connection.QueryAsync<TipoCuenta>(@"Select Id, Nombre, Orden From TiposCuentas Where UsuarioId = @UsuarioId Order By Orden", new {usuarioId});
        }

        public async Task Actualizar( TipoCuenta tipoCuenta)
        {
            using var connection = new SqlConnection(connectionString);
            await connection.ExecuteAsync(@"Update TiposCuentas 
                                            Set Nombre = @Nombre  Where Id = @Id",tipoCuenta);
        }

        public async Task<TipoCuenta> ObtenerPorId(int id, int usuarioId)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryFirstOrDefaultAsync<TipoCuenta>(@"
                                                                SELECT Id, Nombre, Orden
                                                                FROM TiposCuentas
                                                                WHERE Id = @Id AND UsuarioId = @UsuarioId", new { id, usuarioId });
        }
        public async Task Borrar(int id)
        {
            var connection = new SqlConnection(connectionString);
            await connection.ExecuteAsync("Delete TiposCuentas Where Id = @Id", new { id }); 
        }

        public async Task Ordenar(IEnumerable<TipoCuenta> tipoCuentasOrdenados)
        {
            var query = "Update TiposCuentas Set Orden = @Orden Where Id = @Id;";
            using var connection = new SqlConnection(connectionString);
            await connection.ExecuteAsync(query, tipoCuentasOrdenados);
        }

    }
}
