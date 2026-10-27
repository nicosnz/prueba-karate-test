Feature: Crud para crear Usuario

  Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = authHeader
    * def req_headers = { Authorization: '#(authHeader)' }
    * def dataGenerator = Java.type('Utils.DataGenerator') 
    
    @Regresion
    Scenario: Crear un nuevo usuario exitosamente
        * def email = randomEmail()
        * def name = dataGenerator.getRandonName()
        Given path '/users'
        And request
            """
            {
                "name": "#(name)",
                "gender": "male",
                "email": "#(email)",
                "status": "active"
            }
            """
        When method post
        Then status 201
        And match response ==
            """
            {
                id: '#number',
                name: "#(name)",
                email: "#(email)",
                gender: "male",
                status: "active"
            }
            """

    @feature2
    Scenario: Crear y Obtener un usuario
        * def email = randomEmail()
        * def name = dataGenerator.getRandonName()
        Given path '/users'
        And request
            """
            {
                "name": "#(name)",
                "gender": "male",
                "email": "#(email)",
                "status": "active"
            }
            """
        When method post
        Then status 201
        And match response ==
            """
            {
                id: '#number',
                name: "#(name)",
                email: "#(email)",
                gender: "male",
                status: "active"
            }
            """
        * def userId = response.id
        * print userId
        * def userEmail = response.email
        Given path '/users', userId
        And headers req_headers
        When method get
        Then status 200
        And match response.email == userEmail

    @feature3
    Scenario: Crear y Eliminar usuario
        * def email = randomEmail()
        * def name = dataGenerator.getRandonName()
        Given path '/users'
        And request
            """
            {
                "name": "#(name)",
                "gender": "male",
                "email": "#(email)",
                "status": "active"
            }
            """
        When method post
        Then status 201
        And match response ==
            """
            {
                id: '#number',
                name: "#(name)",
                email: "#(email)",
                gender: "male",
                status: "active"
            }
            """
        * def userId = response.id
        * print userId
        * def userEmail = response.email
        Given path '/users', userId
        And headers req_headers
        When method get
        Then status 200
