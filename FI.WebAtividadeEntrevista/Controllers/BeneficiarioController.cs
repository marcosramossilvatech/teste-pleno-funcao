using FI.AtividadeEntrevista.BLL;
using WebAtividadeEntrevista.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FI.AtividadeEntrevista.DML;

namespace WebAtividadeEntrevista.Controllers
{
    public class BeneficiarioController : Controller
    {

        [HttpPost]
        public JsonResult Alterar(Beneficiario model)
        {
            BoBeneficiario bo = new BoBeneficiario();

            if (!this.ModelState.IsValid)
            {
                List<string> erros = (from item in ModelState.Values
                                      from error in item.Errors
                                      select error.ErrorMessage).ToList();

                Response.StatusCode = 400;
                return Json(string.Join(Environment.NewLine, erros));
            }
            else
            {
                bo.Alterar(new Beneficiario()
                {
                    Id = model.Id,
                    CPF = model.CPF,
                    Nome = model.Nome
                });

                return Json("Cadastro alterado com sucesso");
            }
        }

        [HttpGet]
        public JsonResult BeneficiarioList(int idCliente)
        {
            try
            {

                List<Beneficiario> beneficiarios = new BoBeneficiario().Consultar(idCliente);

                return Json(beneficiarios, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { error = "Erro ao buscar os beneficiários: " + ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpGet]
        public JsonResult VerificarCPFBeneficiario(Beneficiario model)
        {
            try
            {
                BoBeneficiario bo = new BoBeneficiario();
                var retorno = bo.VerificarExistencia(model.CPF, model.IdCliente);
                if (retorno)
                {
                    Response.StatusCode = 400;
                    return Json(retorno.ToString());
                }
                return Json(false);
            }
            catch (Exception ex)
            {
                return Json(new { error = "Erro ao buscar os beneficiários: " + ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpDelete]
        public JsonResult Excluir(int id)
        {
            BoBeneficiario bo = new BoBeneficiario();
            try
            {
                bo.Excluir(id);
                return Json("Exclusão efetuada com sucesso");
            }
            catch (Exception ex)
            {
                return Json(new { Result = "ERROR", Message = ex.Message });
            }
        }


    }
}