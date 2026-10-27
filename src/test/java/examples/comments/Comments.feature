    Feature: Api para probar post

    Background:
    * url baseUrl
    * header Accept = 'application/json'
    * header Content-Type = 'application/json'
    * header Authorization = authHeader
    * def req_headers = { Authorization: '#(authHeader)' }
    * def dataGenerator = Java.type('Utils.DataGenerator')

    @Regresion
    Scenario: Crear un nuevo usuario, un post y un comentario

    * def email = randomEmail()
    * def name = dataGenerator.getRandonName()
    * def postTitle = randomTitle()
    * def postBody = randomBody()

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
    * def userEmail = response.email

    Given path '/users', userId, '/posts'
    And headers req_headers
    And request
        """
        {
            "user_id": "#(userId)",
            "title": "#(postTitle)",
            "body": "#(postBody)"
        }
        """
    When method post
    Then status 201
    * def postId = response.id

    * def commentName = dataGenerator.getRandonName()
    * def commentBody = randomBody()

    Given path '/comments'
    And headers req_headers
    And request
        """
        {
            "post_id": "#(postId)",
            "name": "#(commentName)",
            "email": "#(userEmail)",
            "body": "#(commentBody)"
        }
        """
    When method post
    Then status 201
    