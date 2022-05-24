﻿using Dapper;
using ManejoPresupuesto.Models;
using Microsoft.Data.SqlClient;

namespace ManejoPresupuesto.Servicios
{
    public interface IRepositorioCategorias
    {
        Task Actualizar(Categoria categoria);
        Task Crear(Categoria categoria);
        Task<Categoria> ObeterPorId(int id, int usuarioId);
        Task<IEnumerable<Categoria>> Obtener(int usuarioId, PaginacionViewModel paginacion);
        Task<IEnumerable<Categoria>> Obtener(int usuarioId, TipoOperacion tipoOperacionId);
    }
    public class RepositorioCategorias: IRepositorioCategorias
    {
        private readonly string connectionString;
        public RepositorioCategorias(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("DefaultConnection");
        }

        public async Task Crear(Categoria categoria)
        {
            using var connection = new SqlConnection(connectionString);
            var id = await connection.QuerySingleAsync<int>(@"INSERT INTO Categorias (Nombre, TipoOperacionId, UsuarioId)
                VALUES (@Nombre, @TipoOperacionId, @UsuarioId)
                        SELECT SCOPE_IDENTITY();", categoria);

            categoria.Id = id;
        }

        public async Task<IEnumerable<Categoria>> Obtener(int usuarioId, PaginacionViewModel paginacion)
        {
            using  var connection = new SqlConnection(connectionString);
            return await connection.QueryAsync<Categoria>( @$"
                                                        Select * From Categorias Where UsuarioId = @usuarioId
                                                        ORDER BY Nombre
                                                        OFFSET {paginacion.RecordsASaltar} ROWS FETCH NEXT {paginacion.RecordsPorPagina} ROWS ONLY", 
                                                        new { usuarioId });
        }
        public async Task<IEnumerable<Categoria>> Obtener(int usuarioId, TipoOperacion tipoOperacionId)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryAsync<Categoria>("Select * From Categorias Where UsuarioId = @usuarioId AND TipoOperacionId = @tipoOperacionId", new { usuarioId , tipoOperacionId });
        }

        public async Task<Categoria> ObeterPorId(int id, int usuarioId)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QueryFirstOrDefaultAsync<Categoria>(
                @"Select * From Categorias Where Id = @Id And UsuarioId = @UsuarioId", new {id, usuarioId});
        }

        public async Task Actualizar(Categoria categoria)
        {
            using var connection = new SqlConnection(connectionString);
            await connection.ExecuteAsync(@"Update Categorias Set Nombre = @Nombre, TipoOperacionId = @TipoOperacionId Where Id = @Id", categoria);
        }

        
    }
}
