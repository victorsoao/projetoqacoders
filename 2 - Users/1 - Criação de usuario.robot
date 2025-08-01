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
 
Criar um usuário
    Create User
 
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
 
Create User
    ${token} =    Realizar Login
    ${body} =    Create Dictionary
    ...    fullName=Martins Elifas 
    ...    mail=elifass71@gmail.com
    ...    password=1234@Test
    ...    accessProfile=ADMIN
    ...    cpf=08191182023
    ...    confirmPassword=1234@Test
     ${resposta_usuario}=    POST On Session    alias=supernatural    url=/user/?token=${token}    json=${body}    expected_status=500