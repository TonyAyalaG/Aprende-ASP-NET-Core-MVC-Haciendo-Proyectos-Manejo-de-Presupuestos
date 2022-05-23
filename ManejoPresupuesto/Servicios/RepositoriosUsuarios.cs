using Dapper;
using ManejoPresupuesto.Models;
using Microsoft.Data.SqlClient;

namespace ManejoPresupuesto.Servicios
{
    public interface IRepositoriosUsuarios
    {
        Task<Usuario> BuscarUsuarioPorEmail(string emailNormalizado);
        Task<int> CrearUsuario(Usuario usuario);
    }
    public class RepositoriosUsuarios : IRepositoriosUsuarios
    {
        private readonly string connectionString;
        public RepositoriosUsuarios(IConfiguration configuration)
        {
            connectionString = configuration.GetConnectionString("DefaultConnection");

        }

        public async Task<int> CrearUsuario(Usuario usuario)
        {
            //usuario.EmailNormalizado = usuario.Emal.ToUpper();
            using var connection = new SqlConnection(connectionString);
            var id = await connection.QuerySingleAsync<int>(@"Insert into Usuarios(Email, EmailNormalizado, PasswordHash)
                                                    Values(@Email, @EmailNormalizado, @PasswordHash); Select Scope_IDentity();", usuario);

            return id;
        }

        public async Task<Usuario> BuscarUsuarioPorEmail(string emailNormalizado)
        {
            using var connection = new SqlConnection(connectionString);
            return await connection.QuerySingleOrDefaultAsync<Usuario>("SELECT * FROM Usuarios Where EmailNormalizado = @emailNormalizado", new { emailNormalizado });
        }
    }
}
