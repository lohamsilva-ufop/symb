function Corrigir(){
 
var nexec = document.getElementById("txtqtde").value;
var gabarito = document.getElementById("txtgabarito").value;
var exalunos = document.getElementById("txtexalunos").value;

var texto = "#lang symb/especificacao/conf \\n" +
"quantidade-execucoes: " +nexec + "; \\n" +
"gabarito: "+ gabarito + ";  \\n "+
"dir-aluno-exercicios: "+exalunos + "; ";

var blob = new Blob([texto], {type: "text/plain;charset=utf-8"});
FileSaver.saveAs(blob, "especificacao.rkt");
 
 }