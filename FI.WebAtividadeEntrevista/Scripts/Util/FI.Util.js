function formatCPF(cpf) {
    cpf = cpf.replace(/\D/g, '');
    cpf = cpf.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');

    return cpf;
}

function formatCEP(cep) {
    cep = cep.replace(/\D/g, ''); 
    cep = cep.replace(/(\d{5})(\d{3})/, '$1-$2'); 
    return cep;
}


document.getElementById('CPF').addEventListener('input', function (e) {
    var input = e.target;
    var value = input.value;
    input.value = formatCPF(value);
});

document.getElementById('CPFModal').addEventListener('input', function (e) {
    var input = e.target;
    var value = input.value;
    input.value = formatCPF(value);
});

document.getElementById('CEP').addEventListener('input', function (e) {
    var input = e.target;
    var value = input.value;
    input.value = formatCEP(value);
});