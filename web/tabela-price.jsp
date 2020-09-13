<%-- 
    Document   : tabela-price
    Created on : 12/09/2020, 19:08:14
    Author     : Nayara Cruz
--%>
<%@page  import="java.lang.Math" %>
<%@page contentType="text/html" import="java.text.DecimalFormat"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String erro = null;
    int p;
    double n;
    double t;
    try {
        n = Double.parseDouble(request.getParameter("n"));
        p = Integer.parseInt(request.getParameter("p"));
        t = Double.parseDouble(request.getParameter("t"));
    } catch (Exception ex) {
        n = 0;
        p = 0;
        t = 0;
        if ((request.getParameter("n") != null) || (request.getParameter("p") != null) || (request.getParameter("t") != null)) {
            erro = "Número inválido como parâmetro";
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="WEB-INF/jspf/cabecalho.jspf" %>
        <title>Tabela Price - WebSite</title>
    </head>
    <body> 
        <%@include file="WEB-INF/jspf/menu.jspf" %>
        <div class="container-fluid">
            <h1 style="color:lightslategray;">Tabela Price (PRICE)</h1>
            <hr>
        </div>
        <div class="container">
            <br>
            <h3 style="color:lightslategray;">Como Funciona?</h3>
            <div>
                <br>
                <p>O sistema francês de amortização, mais conhecido como tabela PRICE possui 
                <u>prestações sempre iguais</u> ao longo dos períodos, formando uma série uniforme de pagamentos (PMT).
                   A tabela PRICE é muito usada no dia a dia das empresas, principalmente no comércio, 
                   para cálculo da parcela de de compras a prazo. Também é muito utilizado em empréstimos de curto e 
                   médio prazo. Sua aplicações em financiamentos de longo prazo como os 
                   financiamentos imobiliários por exemplo , não é muito comum 
                   (o sistema mais comum é o <a href="amortizacao-constante.jsp">SAC</a>).</p>
                <p>Aqui, como no (SAC), a parcela é resultado da soma entre amortização e juros, ou seja:</p>
                <p><strong>Parcela = Amortização + Juros</strong></p>
                <br>
                <p>Para entender melhor como esse sistema funciona, simule um empréstimo digitando os dados nos campos abaixo:</p>
                <hr>
                <form>
                    <p>Digite o valor do empréstimo:
                        <input type="number" name="n" step="0.01"/></p>
                    <p>Digite o número de parcelas:
                        <input type="number"  name="p" /></p>
                    <p>Digite o valor da taxa a.m. :
                        <input type="number" name="t" step="0.01"/></p> 
                    <input type="submit" name="Confirmar" value="Calcular"/>
                </form>
            </div>
            <%if ((request.getParameter("n") == null) || (request.getParameter("p") == null) || (request.getParameter("t") == null)) {%>
            <%} else if (erro != null) {%>
            <div><%= erro%></div>
            <%} else { DecimalFormat df = new DecimalFormat("#0.00"); %>
            <hr>
            <table border="1">
                <tr align="center" style="background-color: #C0C0C0">
                    <th style="width: 100px">Mês</th>
                    <th style="width: 100px">Juros</th>
                    <th style="width: 100px">Amortização</th>
                    <th style="width: 100px">Prestação</th>                    
                    <th style="width: 100px">Saldo Devedor</th>
                </tr>
                <tr>
                    <td style="background-color: #DCDCDC"> </td>
                    <td style="background-color: #DCDCDC"> </td>
                    <td style="background-color: #DCDCDC"> </td>
                    <td style="background-color: #DCDCDC"> </td>
                    <td align="right">R$<%= df.format(n) %></td>
                </tr>
                <%
                    double taxa = t / 100;
                    double prest = ((n * (Math.pow(1 + taxa, p) * taxa))) / (((Math.pow(1 + taxa, p) - 1)));
                    double juros = (n * taxa);
                    double amort = prest - juros;
                    double saldoDev = (n - amort);
                    double totalJ = 0;
                    double mesAnt = 0;
                    String a = "TOTAL";
                    for (int i = 1; i <= p; i++) {%>

                <tr>
                    <td align="center"><%= i%></td>
                    <td align="right">R$  <%= df.format(juros)%></td>
                    <td align="right">R$  <%= df.format(amort)%></td>
                    <td align="right">R$  <%= df.format(prest)%></td>
                    <td align="right">R$  <%= df.format(saldoDev)%></td>
                </tr>  
                <%  totalJ = totalJ + juros;
                    mesAnt = saldoDev;
                    juros = (saldoDev * taxa);
                    amort = (prest - juros);
                    saldoDev = (mesAnt - amort);
                %>
                <%}%>
                <tr style="background-color: #C0C0C0">
                    <td align="center"><strong><%= a%></strong></td>
                    <td align="right"><strong>R$ <%= df.format(totalJ)%></strong></td>
                    <td align="right"><strong>R$ <%= df.format(n)%></strong></td>
                    <td align="right"><strong>R$ <%= df.format(n + totalJ)%></strong></td>
                    <td align="right"><strong>R$ <%= df.format(saldoDev - saldoDev)%></strong></td>
                </tr> 
            </table>
            <%}%>
        </div>
        <%@include file="WEB-INF/jspf/rodape.jspf" %>
    </body>
</html>