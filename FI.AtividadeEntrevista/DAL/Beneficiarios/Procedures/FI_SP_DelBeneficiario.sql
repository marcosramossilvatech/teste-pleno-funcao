﻿CREATE PROC FI_SP_DelBeneficiarioPorID
	@ID BIGINT
AS
BEGIN
	DELETE BENEFICIARIOS WHERE ID = @ID
END


CREATE PROC FI_SP_DelBeneficiarioPorIDCliente
	@IDCLIENTE BIGINT
AS
BEGIN
	DELETE BENEFICIARIOS WHERE IDCLIENTE = @IDCLIENTE
END