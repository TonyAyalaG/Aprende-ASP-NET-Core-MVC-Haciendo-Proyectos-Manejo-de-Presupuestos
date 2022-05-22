﻿using AutoMapper;
using ManejoPresupuesto.Models;
using ManejoPresupuesto.Servicios;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;

namespace ManejoPresupuesto.Controllers
{
    public class TransaccionesController: Controller
    {
        private readonly IServicioUsuarios servicioUsuarios;
        private readonly IRepositorioCuentas repositorioCuentas;
        private readonly IRepositorioCategorias repositorioCategorias;
        private readonly IRepositorioTransacciones repositorioTransacciones;
        private readonly IMapper mapper;
        private readonly IServicioReportes servicioReportes;

        public TransaccionesController(IServicioUsuarios servicioUsuarios, IRepositorioCuentas repositorioCuentas, IRepositorioCategorias repositorioCategorias, IRepositorioTransacciones repositorioTransacciones, IMapper mapper, IServicioReportes servicioReportes)
        {
            this.servicioUsuarios = servicioUsuarios;
            this.repositorioCuentas = repositorioCuentas;
            this.repositorioCategorias = repositorioCategorias;
            this.repositorioTransacciones = repositorioTransacciones;
            this.mapper = mapper;
            this.servicioReportes = servicioReportes;
        }
        public async Task<IActionResult> Index(int mes, int ano)
        {
            var usuarioId = servicioUsuarios.ObtenerUsuarioId();

            //DateTime fechaInicio;
            //DateTime fechaFin;

            //if (mes <= 0 || mes > 12 || ano <= 1900)
            //{
            //    var hoy = DateTime.Today;
            //    fechaInicio = new DateTime(hoy.Year, hoy.Month, 1);
            //}
            //else
            //{
            //    fechaInicio = new DateTime(ano, mes, 1);
            //}
            //fechaFin = fechaInicio.AddMonths(1).AddDays(-1);

            //var parametro = new ParametroObtenerTransaccionesPorUsuario()
            //{
            //    UsuarioId = usuarioId,
            //    FechaFin = fechaFin,
            //    FechaInicio = fechaInicio
            //};

            //var transacciones = await repositorioTransacciones.ObtenerPorUsuarioId(parametro);
            //var modelo = new ReporteTransaccionesDetalladas();

            //var transaccionesPorFecha = transacciones.OrderBy(x => x.FechaTransaccion)
            //    .GroupBy(x => x.FechaTransaccion)
            //    .Select(grupo => new ReporteTransaccionesDetalladas
            //    .TransaccionesPorFecha()
            //    {
            //        FechaTransaccion = grupo.Key,
            //        Transacciones = grupo.AsEnumerable()
            //    });

            //modelo.TransaccionesAgrupadas = transaccionesPorFecha;
            //modelo.FechaInicio = fechaInicio;
            //modelo.FechaFin = fechaFin;

            //ViewBag.mesAnterior = fechaInicio.AddMonths(-1).Month;
            //ViewBag.anoAnterior = fechaInicio.AddMonths(-1).Year;
            //ViewBag.mesPosterior = fechaInicio.AddMonths(1).Month;
            //ViewBag.anoPosterior = fechaInicio.AddMonths(1).Year;
            //ViewBag.urlRetorno = HttpContext.Request.Path + HttpContext.Request.QueryString;
            var modelo = await servicioReportes.ObtenerReporteTransaccionesDetalladas(usuarioId, mes, ano, ViewBag);
            return View(modelo);
        }
       
        public async Task<IActionResult> Semanal(int mes, int ano)
        {
            var usuarioId = servicioUsuarios.ObtenerUsuarioId();
            IEnumerable<ResultadoObtenerPorSemana> transaccionesPorSemana = 
                await servicioReportes.ObtenerReporteSemanal(usuarioId, mes, ano, ViewBag);
            var agrupado = transaccionesPorSemana.GroupBy(x => x.Semana).Select(x => 
            new ResultadoObtenerPorSemana()
            {
                Semana = x.Key,
                Ingresos = x.Where(x => x.TipoOperacionId == TipoOperacion.Ingreso).Select(x => x.Monto).FirstOrDefault(),
                Gastos = x.Where(x => x.TipoOperacionId == TipoOperacion.Gasto).Select(x => x.Monto).FirstOrDefault()
            }).ToList();

            if(ano == 0 || mes == 0)
            {
                var hoy = DateTime.Today;
                ano = hoy.Year;
                mes = hoy.Month;
            }
            var fechaReferencia = new DateTime(ano, mes, 1);
            var diasDelMes = Enumerable.Range(1, fechaReferencia.AddMonths(1).AddDays(-1).Day);

            var diasSegmentados = diasDelMes.Chunk(7).ToList();

            for(int i = 0; i < diasSegmentados.Count(); i++)
            {
                var semana = i + 1;
                var fechaInicio = new DateTime(ano, mes, diasSegmentados[i].First());
                var fechaFin = new DateTime(ano, mes, diasSegmentados[i].Last());
                var grupoSemana = agrupado.FirstOrDefault(x => x.Semana == semana);

                if(grupoSemana is null)
                {
                    agrupado.Add(new ResultadoObtenerPorSemana()
                    {
                        Semana = semana,
                        FechaInicio = fechaInicio,
                        FechaFin = fechaFin
                    });
                }
                else
                {
                    grupoSemana.FechaInicio = fechaInicio;
                    grupoSemana.FechaFin = fechaFin;
                }
            }
            agrupado = agrupado.OrderByDescending(x => x.Semana).ToList();
            var modelo = new ReporteSemanalViewModel();
            modelo.TransaccionesPorSemana = agrupado;
            modelo.FechaReferencia = fechaReferencia;
            return View(modelo);
        }
        public IActionResult Mensual()
        {
            return View();
        }
        public IActionResult ExcelReporte()
        {
            return View();
        }
        public IActionResult Calendario()
        {
            return View();
        }

        [HttpGet]
        public async Task<IActionResult> Crear()
        {
            var usuarioId = servicioUsuarios.ObtenerUsuarioId();
            var modelo = new TransaccionCreacionViewModel();
            modelo.Cuentas = await ObtenerCuentas(usuarioId);
            modelo.Categorias = await ObtenerCategorias(usuarioId, modelo.TipoOperacionId);
            return View(modelo);
        }

        [HttpPost]
        public async Task<IActionResult> Crear(TransaccionCreacionViewModel modelo)
        {
            var usuarioId = servicioUsuarios.ObtenerUsuarioId();
            if (!ModelState.IsValid)
            {
                modelo.Cuentas = await ObtenerCuentas(usuarioId);
                modelo.Categorias = await ObtenerCategorias(usuarioId, modelo.TipoOperacionId);
                return View(modelo);
            }
            var cuenta = await repositorioCuentas.ObtenerPorId(modelo.CuentaId, usuarioId);
            if (cuenta is null)
            {
                return RedirectToAction("NoEncontrado", "Home");
            }
            var categoria = await repositorioCategorias.ObeterPorId(modelo.CategoriaId,usuarioId);
            if (categoria is null)
            {
                return RedirectToAction("NoEncontrado", "Home");
            } 
            modelo.UsuarioId = usuarioId;
            if (modelo.TipoOperacionId == TipoOperacion.Gasto)
            {
                modelo.Monto *= -1;
            }
            await repositorioTransacciones.Crear(modelo);
            return RedirectToAction("Index");

        }

        [HttpGet]
        public async Task<IActionResult> Editar(int id, string urlRetorno = null)
        {
            var usuarioId = servicioUsuarios.ObtenerUsuarioId();
            var transaccion = await repositorioTransacciones.ObtenerPorId(id, usuarioId);

            if (transaccion is null)
            {
                return RedirectToAction("NoEncontrado", "Home");
            }

            var modelo = mapper.Map<TransaccionActualizacionViewModel>(transaccion);
            modelo.MontoAnterior = modelo.Monto;
            if (modelo.TipoOperacionId == TipoOperacion.Gasto)
            {
                modelo.MontoAnterior = modelo.Monto * -1;
            }

            modelo.CuentaAnteriorId = transaccion.CuentaId;
            modelo.Categorias = await ObtenerCategorias(usuarioId, transaccion.TipoOperacionId);
            modelo.Cuentas = await ObtenerCuentas(usuarioId);
            modelo.UrlRetorno = urlRetorno;
            return View(modelo);
             
        }

        [HttpPost]
        public async Task<IActionResult> Editar(TransaccionActualizacionViewModel modelo)
        {
            var usuarioId = servicioUsuarios.ObtenerUsuarioId();
            if (!ModelState.IsValid)
            {
                modelo.Cuentas = await ObtenerCuentas(usuarioId);
                modelo.Categorias = await ObtenerCategorias(usuarioId, modelo.TipoOperacionId);
                return View(modelo);
            }

            var cuenta = await repositorioCuentas.ObtenerPorId(modelo.CuentaId, usuarioId);
            if ( cuenta is null) return RedirectToAction("NoEncontrado", "Home");
            var categoria = await repositorioCategorias.ObeterPorId(modelo.CategoriaId, usuarioId);
            if(categoria is null) return RedirectToAction("NoEncontrado", "Home");

            var transaccion = mapper.Map<Transaccion>(modelo);
            if(modelo.TipoOperacionId == TipoOperacion.Gasto)
            {
                transaccion.Monto *= -1;
            }
            await repositorioTransacciones.Actualizar(transaccion, modelo.MontoAnterior, modelo.CuentaAnteriorId);
            if (string.IsNullOrEmpty(modelo.UrlRetorno)) return RedirectToAction("Index");
            else return LocalRedirect(modelo.UrlRetorno);

        }
        [HttpPost]
        public async Task<IActionResult> Borrar(int id, string urlRetorno = null)
        {
            var usuarioId = servicioUsuarios.ObtenerUsuarioId();
            var transaccion = await repositorioTransacciones.ObtenerPorId(id, usuarioId);
            if (transaccion is null) return RedirectToAction("NoEncontrado", "Home");

            await repositorioTransacciones.Borrar(id);
            if (string.IsNullOrEmpty(urlRetorno)) return RedirectToAction("Index");
            else return LocalRedirect(urlRetorno);

            return RedirectToAction("Index");
        }

        private async Task<IEnumerable<SelectListItem>> ObtenerCuentas(int usuarioId)
        {
            var cuentas = await repositorioCuentas.Buscar(usuarioId);
            return cuentas.Select(x => new SelectListItem(x.Nombre, x.Id.ToString()));
        }
        private async Task<IEnumerable<SelectListItem>> ObtenerCategorias(int usuarioId, TipoOperacion tipoOperacion)
        {
            var categorias = await repositorioCategorias.Obtener(usuarioId, tipoOperacion);
            return categorias.Select(x => new SelectListItem(x.Nombre, x.Id.ToString()));
        }

        [HttpPost]
        public async Task<IActionResult> ObtenerCategorias([FromBody] TipoOperacion tipoOperacion)
        {
            var usuarioId = servicioUsuarios.ObtenerUsuarioId();
            var categorias = await ObtenerCategorias(usuarioId, tipoOperacion);
            return Ok(categorias);
        }

    }
}
