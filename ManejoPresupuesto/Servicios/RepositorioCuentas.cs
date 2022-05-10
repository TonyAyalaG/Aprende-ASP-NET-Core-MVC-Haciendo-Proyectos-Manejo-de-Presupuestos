﻿using Dapper;
using ManejoPresupuesto.Models;
using Microsoft.Data.SqlClient;

namespace ManejoPresupuesto.Servicios
{
    public interface IRepositorioCuentas
    {
        Task<IEnumerable<Cuenta>> Buscar(int usuarioId);
        Task Crear(Cuenta cuenta);
    }
    public class RepositorioCuentas: IRepositorioCuentas
    {
        private readonly string connectionString;
        public RepositorioCuentas(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("DefaultConnection");
                            
        }

        public async Task Crear(Cuenta cuenta)
        {
            using var connection = new  SqlConnection(connectionString);
            var id = await connection.QuerySingleAsync<int>(@"Insert Into Cuentas
                                                (Nombre, TipoCuentaId, Descripcion, Balance)
                                          Values (@Nombre, @TipoCuentaId, @Descripcion, @Balance);
                                        Select SCOPE_IDENTITY();", cuenta);
            cuenta.Id = id;
        }

        public async Task<IEnumerable<Cuenta>> Buscar(int usuarioId)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryAsync<Cuenta>(@"
                                                        Select Cuentas.Id, Cuentas.Nombre, Balance, tc.Nombre as TipoCuenta
                                                        from Cuentas
                                                        Inner Join TiposCuentas tc On tc.Id = Cuentas.TipoCuentaId
                                                        Where tc.UsuarioId = @UsuarioId Order by tc.Orden", new { usuarioId });
        }
    }
}
