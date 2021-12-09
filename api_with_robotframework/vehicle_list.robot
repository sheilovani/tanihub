*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     JSONLibrary

*** Variables ***
${base_url}              https://ghibliapi.herokuapp.com
${get_endpoint}          /vehicles/

*** Test Case ***

Get All Vehicle List and Then Get Response 200 OK
    Create Session                    get_vehicle_list                          ${base_url}     verify=true
    ${headers}                        Create Dictionary                         Content-Type=application/json
    ${response}=                      Get Request       get_vehicle_list        ${get_endpoint}    headers=${headers}
    Should Be Equal As Strings        ${response.status_code}                   200
    Set Global Variable               ${response}
    Log To Console                    ${response.json()}

    ${vehicleId}=                     Set Variable                              ${response.json()[0]["id"]}
    Set Global Variable               ${vehicleId}
    ${vehicleId1}=                    Set Variable                              ${response.json()[1]["id"]}
    Set Global Variable               ${vehicleId1}
    ${vehicleId2}=                    Set Variable                              ${response.json()[2]["id"]}
    Set Global Variable               ${vehicleId2}

Get Vehicle List by Id and Then Get Response 200 OK
    Create Session                    get_vehicle_list_by_id                    ${base_url}     verify=true
    ${headers}                        Create Dictionary                         Content-Type=application/json
    ${response}=                      Get Request    get_vehicle_list_by_id     ${get_endpoint}/${vehicleId}    headers=${headers}
    Should Be Equal As Strings        ${response.status_code}                   200
    Set Global Variable               ${response}
    Log To Console                    ${response.json()}

    Should Be Equal As Strings        ${response.json()["name"]}                Air Destroyer Goliath
    Should Be Equal As Strings        ${response.json()["description"]}         A military airship utilized by the government to access Laputa
    Should Be Equal As Strings        ${response.json()["vehicle_class"]}       Airship
    Should Be Equal As Strings        ${response.json()["length"]}              1,000
    Should Be Equal As Strings        ${response.json()["pilot"]}               https://ghibliapi.herokuapp.com/people/40c005ce-3725-4f15-8409-3e1b1b14b583
    Should Be Equal As Strings        ${response.json()["films"][0]}            https://ghibliapi.herokuapp.com/films/2baf70d1-42bb-4437-b551-e5fed5a87abe
    Should Be Equal As Strings        ${response.json()["url"]}                 https://ghibliapi.herokuapp.com/vehicles/4e09b023-f650-4747-9ab9-eacf14540cfb

Get Vehicle List by second Id and Then Get Response 200 OK
    Create Session                    get_vehicle_list_by_id                    ${base_url}     verify=true
    ${headers}                        Create Dictionary                         Content-Type=application/json
    ${response}=                      Get Request    get_vehicle_list_by_id     ${get_endpoint}/${vehicleId1}    headers=${headers}
    Should Be Equal As Strings        ${response.status_code}                   200
    Set Global Variable               ${response}
    Log To Console                    ${response.json()}

    Should Be Equal As Strings        ${response.json()["name"]}                Red Wing
    Should Be Equal As Strings        ${response.json()["description"]}         An experimental aircraft captured by Porco. Named Savoia S.21
    Should Be Equal As Strings        ${response.json()["vehicle_class"]}       Airplane
    Should Be Equal As Strings        ${response.json()["length"]}              20
    Should Be Equal As Strings        ${response.json()["pilot"]}               https://ghibliapi.herokuapp.com/people/6523068d-f5a9-4150-bf5b-76abe6fb42c3
    Should Be Equal As Strings        ${response.json()["films"][0]}            https://ghibliapi.herokuapp.com/films/ebbb6b7c-945c-41ee-a792-de0e43191bd8
    Should Be Equal As Strings        ${response.json()["url"]}                 https://ghibliapi.herokuapp.com/vehicles/d8f893b5-1dd9-41a1-9918-0099c1aa2de8

Get Vehicle List by Third Id and Then Get Response 200 OK
    Create Session                    get_vehicle_list_by_id                    ${base_url}     verify=true
    ${headers}                        Create Dictionary                         Content-Type=application/json
    ${response}=                      Get Request    get_vehicle_list_by_id     ${get_endpoint}/${vehicleId2}    headers=${headers}
    Should Be Equal As Strings        ${response.status_code}                   200
    Set Global Variable               ${response}
    Log To Console                    ${response.json()}

    Should Be Equal As Strings        ${response.json()["name"]}                Sosuke's Boat
    Should Be Equal As Strings        ${response.json()["description"]}         A toy boat where Sosuke plays
    Should Be Equal As Strings        ${response.json()["vehicle_class"]}       Boat
    Should Be Equal As Strings        ${response.json()["length"]}              10
    Should Be Equal As Strings        ${response.json()["pilot"]}               https://ghibliapi.herokuapp.com/people/a10f64f3-e0b6-4a94-bf30-87ad8bc51607
    Should Be Equal As Strings        ${response.json()["films"][0]}            https://ghibliapi.herokuapp.com/films/758bf02e-3122-46e0-884e-67cf83df1786
    Should Be Equal As Strings        ${response.json()["url"]}                 https://ghibliapi.herokuapp.com/vehicles/923d70c9-8f15-4972-ad53-0128b261d628

Get Vehicle List by Invalid Id and Then Get Response 404 Not Found
    Create Session                    get_vehicle_list_by_id                    ${base_url}     verify=true
    ${headers}                        Create Dictionary                         Content-Type=application/json
    ${response}=                      Get Request    get_vehicle_list_by_id     ${get_endpoint}/${vehicleId2}08    headers=${headers}
    Should Be Equal As Strings        ${response.status_code}                   404
    Set Global Variable               ${response}
    Log To Console                    ${response.json()}

Create Vehicle and Then Get Response 201 Created
    ${data}=                          Load JSON From File                       api_with_robotframework/create_new_data.json

    Create Session                    create_vehicle                            ${base_url}         verify=true
    ${headers}                        Create Dictionary                         Content-Type=application/json
    ${response}=                      Post Request           create_vehicle     ${get_endpoint}     headers=${headers}
    Should Be Equal As Strings        ${response.status_code}                   201
    Log To Console                    ${response.json()}
