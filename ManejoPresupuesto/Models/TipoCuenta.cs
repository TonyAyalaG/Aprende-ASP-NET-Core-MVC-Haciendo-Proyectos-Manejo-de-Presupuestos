using System.ComponentModel.DataAnnotations;

namespace ManejoPresupuesto.Models
{
    public class TipoCuenta
    {
        public int Id { get; set; }
        [Required(ErrorMessage ="El campo {0} es requerido")]
        [StringLength(maximumLength:50, MinimumLength =3,ErrorMessage ="Largo {1} y {2}")]
        public string Nombre { get; set; }
        public int UsuarioId { get; set; }
        public int Orden { get; set; }
    }
}
