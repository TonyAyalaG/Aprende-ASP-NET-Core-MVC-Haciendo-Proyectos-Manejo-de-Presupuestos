﻿using Dapper;
using ManejoPresupuesto.Models;
using Microsoft.Data.SqlClient;

namespace ManejoPresupuesto.Servicios
{
    public interface IRepositorioTransacciones
    {
        Task Actualizar(Transaccion transaccion, decimal montoAnterior, int cuentaAnterior);
        Task Borrar(int id);
        Task Crear(Transaccion transaccion);
        Task<IEnumerable<Transaccion>> ObtenerPorCuentaId(ObtenerTransaccionesPorCuenta modelo);
        Task<Transaccion> ObtenerPorId(int id, int usuarioId);
        Task<IEnumerable<ResultadoObtenerPorSemana>> ObtenerPorSemana(ParametroObtenerTransaccionesPorUsuario modelo);
        Task<IEnumerable<Transaccion>> ObtenerPorUsuarioId(ParametroObtenerTransaccionesPorUsuario modelo);
    }
    public class RepositorioTransacciones : IRepositorioTransacciones
    {
        private readonly string connectionString;
        public RepositorioTransacciones(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("DefaultConnection");                
        }

        public async Task Crear(Transaccion transaccion)
        {
            using var connection = new SqlConnection(connectionString);
            var id = await connection.QuerySingleAsync<int>("Transacciones_Insertar",
                new
                {
                    transaccion.UsuarioId,
                    transaccion.FechaTransaccion,
                    transaccion.Monto,
                    transaccion.CategoriaId,
                    transaccion.CuentaId,
                    transaccion.Nota
                },
                commandType: System.Data.CommandType.StoredProcedure);
                
        }
        public async Task<IEnumerable<Transaccion>> ObtenerPorCuentaId(ObtenerTransaccionesPorCuenta modelo)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryAsync<Transaccion>(@"select t.Id, t.Monto, t.FechaTransaccion, c.Nombre as Categoria, cu.Nombre as Cuenta, c.TipoOperacionId
                                                        from Transacciones t
                                                        inner join Categorias c on c.id = t.CategoriaId
                                                        inner join Cuentas cu on cu.Id = t.CuentaId
                                                    Where t.CuentaId =@CuentaId and t.UsuarioId= @UsuarioId and FechaTransaccion Between @FechaInicio And @FechaFin", modelo);
        }
        public async Task<IEnumerable<Transaccion>> ObtenerPorUsuarioId(ParametroObtenerTransaccionesPorUsuario modelo)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryAsync<Transaccion>(@"select t.Id, t.Monto, t.FechaTransaccion, c.Nombre as Categoria, cu.Nombre as Cuenta, c.TipoOperacionId
                                                        from Transacciones t
                                                        inner join Categorias c on c.id = t.CategoriaId
                                                        inner join Cuentas cu on cu.Id = t.CuentaId
                                                    Where  t.UsuarioId= @UsuarioId and FechaTransaccion Between @FechaInicio And @FechaFin
                                                    Order By t.FechaTransaccion DESC", modelo);
        }
        public async Task Actualizar(Transaccion transaccion, decimal montoAnterior, int cuentaAnteriorId)
        {
            using var connection = new SqlConnection(connectionString);
            await connection.ExecuteAsync("Transacciones_Actualizar",
                new
                {
                    transaccion.Id,
                    transaccion.FechaTransaccion,
                    transaccion.Monto,
                    transaccion.CategoriaId,
                    transaccion.CuentaId,
                    transaccion.Nota,
                    montoAnterior,
                    cuentaAnteriorId
                }, commandType: System.Data.CommandType.StoredProcedure);
                
        }

        public async Task<Transaccion> ObtenerPorId(int id, int usuarioId)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryFirstOrDefaultAsync<Transaccion>(@"Select Transacciones.*, cat.TipoOperacionId
                                From Transacciones
                                Inner Join Categorias cat on cat.id = Transacciones.CategoriaId
                                Where Transacciones.Id = @Id And Transacciones.UsuarioId = @UsuarioId", new {id, usuarioId});
        }

        public async Task<IEnumerable<ResultadoObtenerPorSemana>> ObtenerPorSemana(ParametroObtenerTransaccionesPorUsuario modelo)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryAsync<ResultadoObtenerPorSemana>(@"Select datediff(d,@fechaInicio, FechaTransaccion)/7+1 As Semana, Sum(Monto) as Monto, cat.TipoOperacionId
                                                    From Transacciones Inner Join Categorias cat
                                                    on cat.Id= Transacciones.CategoriaId
                                                    Where Transacciones.UsuarioId = @usuarioId And FechaTransaccion Between @fechaInicio and @fechaFin
                                                    Group by datediff(d,@fechaInicio, FechaTransaccion)/7, cat.TipoOperacionId", modelo);
        }
        public async Task Borrar(int id)
        {
            using var connection = new SqlConnection(connectionString);
            await connection.ExecuteAsync("Transacciones_Borrar", new {id}, commandType: System.Data.CommandType.StoredProcedure);
        }

    }


}
