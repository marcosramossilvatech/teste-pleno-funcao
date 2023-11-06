﻿GO
ALTER PROC FI_SP_IncClienteV2
    @NOME          VARCHAR (50) ,
    @SOBRENOME     VARCHAR (255),
	@CPF           VARCHAR (14) ,
    @NACIONALIDADE VARCHAR (50) ,
    @CEP           VARCHAR (9)  ,
    @ESTADO        VARCHAR (2)  ,
    @CIDADE        VARCHAR (50) ,
    @LOGRADOURO    VARCHAR (500),
    @EMAIL         VARCHAR (2079),
    @TELEFONE      VARCHAR (15)
AS
BEGIN
	INSERT INTO CLIENTES (NOME, SOBRENOME,CPF, NACIONALIDADE, CEP, ESTADO, CIDADE, LOGRADOURO, EMAIL, TELEFONE) 
	VALUES (@NOME,@SOBRENOME,@CPF,@NACIONALIDADE,@CEP,@ESTADO,@CIDADE,@LOGRADOURO,@EMAIL,@TELEFONE)

	SELECT SCOPE_IDENTITY()
END
GO


ALTER PROC FI_SP_AltCliente
    @NOME          VARCHAR (50) ,
    @SOBRENOME     VARCHAR (255),
	@CPF           VARCHAR (14) ,
    @NACIONALIDADE VARCHAR (50) ,
    @CEP           VARCHAR (9)  ,
    @ESTADO        VARCHAR (2)  ,
    @CIDADE        VARCHAR (50) ,
    @LOGRADOURO    VARCHAR (500),
    @EMAIL         VARCHAR (2079),
    @TELEFONE      VARCHAR (15),
	@Id           BIGINT
AS
BEGIN
	UPDATE CLIENTES 
	SET 
		NOME = @NOME, 
		SOBRENOME = @SOBRENOME, 
		CPF  = @CPF,
		NACIONALIDADE = @NACIONALIDADE, 
		CEP = @CEP, 
		ESTADO = @ESTADO, 
		CIDADE = @CIDADE, 
		LOGRADOURO = @LOGRADOURO, 
		EMAIL = @EMAIL, 
		TELEFONE = @TELEFONE
	WHERE Id = @Id
END
GO

GO
ALTER PROC FI_SP_ConsCliente
	@ID BIGINT
AS
BEGIN
	IF(ISNULL(@ID,0) = 0)
		SELECT NOME, SOBRENOME, CPF, NACIONALIDADE, CEP, ESTADO, CIDADE, LOGRADOURO, EMAIL, TELEFONE, ID FROM CLIENTES WITH(NOLOCK)
	ELSE
		SELECT NOME, SOBRENOME, CPF, NACIONALIDADE, CEP, ESTADO, CIDADE, LOGRADOURO, EMAIL, TELEFONE, ID FROM CLIENTES WITH(NOLOCK) WHERE ID = @ID
END
GO


GO
ALTER PROC FI_SP_PesqCliente
	@iniciarEm int,
	@quantidade int,
	@campoOrdenacao varchar(200),
	@crescente bit	
AS
BEGIN
	DECLARE @SCRIPT NVARCHAR(MAX)
	DECLARE @CAMPOS NVARCHAR(MAX)
	DECLARE @ORDER VARCHAR(50)
	
	IF(@campoOrdenacao = 'EMAIL')
		SET @ORDER =  ' EMAIL '
	ELSE
		SET @ORDER = ' NOME '

	IF(@crescente = 0)
		SET @ORDER = @ORDER + ' DESC'
	ELSE
		SET @ORDER = @ORDER + ' ASC'

	SET @CAMPOS = '@iniciarEm int,@quantidade int'
	SET @SCRIPT = 
	'SELECT ID, NOME, SOBRENOME, CPF, NACIONALIDADE, CEP, ESTADO, CIDADE, LOGRADOURO, EMAIL, TELEFONE FROM
		(SELECT ROW_NUMBER() OVER (ORDER BY ' + @ORDER + ') AS Row, ID, NOME, SOBRENOME, NACIONALIDADE, CEP, ESTADO, CIDADE, LOGRADOURO, EMAIL, TELEFONE FROM CLIENTES WITH(NOLOCK))
		AS ClientesWithRowNumbers
	WHERE Row > @iniciarEm AND Row <= (@iniciarEm+@quantidade) ORDER BY'
	
	SET @SCRIPT = @SCRIPT + @ORDER
			
	EXECUTE SP_EXECUTESQL @SCRIPT, @CAMPOS, @iniciarEm, @quantidade

	SELECT COUNT(1) FROM CLIENTES WITH(NOLOCK)
END
GO