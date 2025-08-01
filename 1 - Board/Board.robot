*** Settings ***
Documentation    Pegar Token
 
Library           RequestsLibrary
Library           String
Library           Collections
 
*** Variables ***
${baseUrl}    https://api-supernatural.qacoders.dev.br/api/
 
*** Test Cases ***
Validar Login
    Realizar Login
 
Criar board name
    Create boardName
 
*** Keywords ***
Criar Sessao
    ${headers} =    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=supernatural    url=${baseUrl}    headers=${headers}    verify=true
 
Realizar Login
    ${body} =    Create Dictionary
    ...    mail=sysadmin@qacoders.com
    ...    password=1234@Test
   
    Criar Sessao
    ${response} =    POST On Session    alias=supernatural    url=/login    json=${body}
    Status Should Be    200    ${response}
    RETURN    ${response.json()["token"]}
 
Create boardName
    ${token} =    Realizar Login
    ${body} =    Create Dictionary
    ...    boardName="As Aaas"
     ${resposta_usuario}=    POST On Session    alias=supernatural    url=/board/?token=${token}    json=${body}    