
$(document).ready(function () {

    if (document.getElementById("gridBeneficiarios"))
        $('#gridBeneficiarios').jtable({
            title: 'Benificiarios',
            paging: true,
            pageSize: 5, 
            sorting: true, 
            defaultSorting: 'Nome ASC', 
            actions: {
                listAction: urlBeneficiarioList,
            },
            fields: {

                CPF: {
                    title: 'CPF',
                    width: '50%'
                },

                Nome: {
                    title: 'Nome',
                    width: '50%'
                },
                Alterar: {
                    title: '',
                    display: function (data) {
                        return '<button onclick="window.location.href=\'' + urlAlteracao + '/' + data.record.Id + '\'" class="btn btn-primary btn-sm">Alterar</button>';
                    }
                },
                Alterar: {
                    title: '',
                    display: function (data) {
                        return '<button onclick="window.location.href=\'' + urlAlteracao + '/' + data.record.Id + '\'" class="btn btn-primary btn-sm">Excluir</button>';
                    }
                }
            }
        });

    //Load student list from server
    if (document.getElementById("gridBeneficiarios"))
        $('#gridBeneficiarios').jtable('load');
})

