#! /bin/bash
# //////////////////////////////////////////////////////////////////////////////////////////
# https://docs.microsoft.com/en-us/cli/azure/cosmosdb?view=azure-cli-latest
# https://towardsdatascience.com/getting-started-with-graph-databases-in-azure-cosmos-db-cbfbf708cda5

#   File Type   : BASH Script (needs GIT-CLI,  AZURE-CLI  installed  ).
#   test
#   Description : This script builds "waardepapieren" containers and ships images to hub.docker.com and beyond to ACI
#   Modified           Date                 Description
#   Peter Bosch        20210202            bash file generator.  
#  ss
# //////////////////////////////////////////////////////////////////////////////////////////
#  File:            :bfg.bash
#  version          :20200101 v7
#  File Type        :Bash is a command processor that typically runs in a text window
#                    Bash can also read and execute commands from a file, called a shell script.
#                    Personally, I tend to build with a small shell script in my folder (build.bash) 
#                    which passes any args and includes the name of the image there to save typing. 
#                    And for production, the build is handled by a ci/cd server that has the image name inside this pipeline script.
#  Purpose          :
#                   Create a resource group, Cosmos account, database with throughput and graph with throughput
#                   az group create -n $resourceGroupName -l $location
#                   az cosmosdb create -n $accountName -g $resourceGroupName --capabilities EnableGremlin
#                   az cosmosdb gremlin database create -a $accountName -g $resourceGroupName -n $databaseName --throughput $originalThroughput
#                   az cosmosdb gremlin graph create -a $accountName -g $resourceGroupName -d $databaseName -n $graphName -p '/zipcode' --throughput $originalThroughput


#  Title:           :cloutuh ezahr
#  Category         :azure cli   az cosmosdb 
#  Identificatie    :https://github.com/BoschPeter/AZ_ACI_waardepapieren-demo_westeurope_azurecontainer_io
#     
# here we go
# ----------------------------------
# Step : Define variables
# ----------------------------------

# define your feedback here

# Variables for Gremlin API resources
UNIQUEID=$RANDOM    
RESOURCEGROUPNAME='rg_cosmos-delhaye'  #'Group-10770'  #    "Group-$UNIQUEID"
LOCATION='germanywestcentral'      # az account list-LOCATIONs -o table
COSMOSDB_ACCOUNTNAME='cosmos-delhaye'       ##"cosmos-$UNIQUEID" #needs to be lower case  https://portal.azure.com/#@boschpeteroutlook.onmicrosoft.com/resource/subscriptions/87d504e9-46e8-4b87-8f72-f207ee8e6dad/resourceGroups/Group-10770/providers/Microsoft.DocumentDB/databaseAccounts/cosmos-10770
COSMOSDB_DATABASENAME='delhayeDB'
COSMOSDB_GRAPHNAME='PeopleGraph'



DOUBLE_CHECK=true
WRITE_CODE=true
MENU=true
PROMPT=false # echo parameters


### barf
enter_cont() {
    echo
    echo
    echo -n "Press enter to Continue"
    read
}

##################################################################
# Purpose: show bash parameters
# Arguments:
# Return:
##################################################################
show_parameters(){

echo "UNIQUEID=" $UNIQUEID    
echo "RESOURCEGROUPNAME=" $RESOURCEGROUPNAME 
echo "LOCATION= " $LOCATION  
echo "COSMOSDB_ACCOUNTNAME=" $COSMOSDB_ACCOUNTNAME 
echo "COSMOSDB_DATABASENAME=" $COSMOSDB_DATABASENAME 
echo "COSMOSDB_GRAPHNAME=" $COSMOSDB_GRAPHNAME 
#echo -n "Press enter to Continue"
enter_cont
clear

}


##################################################################
# Purpose: show main menu
# Arguments:
# Return:
##################################################################
show_main_menu(){
clear
# A menu driven shell script
#"A menu is nothing but a list of commands presented to a user by a shell script"

# ----------------------------------
# Step: User defined function  10 20 30 ( 40 50)
# ----------------------------------
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}
# function to display menus
show_menus() {
  echo "~~~~~~~~~~~~~~~~~~~~~"
  echo " M A I N - M E N U "
  echo "~~~~~~~~~~~~~~~~~~~~~"
  echo " 0. show_parameters                                                              "
  echo " 1. az login  -u  bosch.peter@outlook.com                                        "
  echo " 2.  Create-a-resource-group     $RESOURCEGROUPNAME                              "
  echo " 3.  Delete-a-resource-group     $RESOURCEGROUPNAME                              "
  echo " 4.  Create-a-Cosmos-account-for-Gremlin-API  $COSMOSDB_ACCOUNTNAME              "
  echo " 5.  Delete-a-Cosmos-account-for-Gremlin-API  $COSMOSDB_ACCOUNTNAME              "
  echo " 6.  Create-a-Gremlin-database   $COSMOSDB_DATABASENAME                          "
  echo " 7.  Delete-a-Gremlin-database   $COSMOSDB_DATABASENAME                          "
  echo " 8.  Create-a-Gremlin-graph      $COSMOSDB_GRAPHNAME                             "
  echo " 9.  Delete-a-Gremlin-graph      $COSMOSDB_GRAPHNAME                             "
  # echo "  9. show_parameters                                                       "
  # echo " 10. show_parameters                                                       "
  # echo " 11. show_parameters                                                       "
  # echo " 12. show_parameters                                                       "
  # echo " 13. show_parameters                                                       "
  # echo " 14. show_parameters                                                       "
  # echo " 15. show_parameters                                                       "
  # echo " 16. show_parameters                                                       "
  # echo " 17. show_parameters                                                       "
  # echo " 18. show_parameters                                                       "
  # echo " 19. show_parameters                                                       "
  # echo " 20. show_parameters                                                       "
  # echo " 21. show_parameters                                                       "
  # echo " 22. show_parameters                                                       "
  # echo " 23. show_parameters                                                       "
  # echo " 24. show_parameters                                                       "
  # echo " 25. show_parameters                                                       "
  # echo " 26. show_parameters                                                       "
  # echo " 27. show_parameters                                                       "
  # echo " 28. show_parameters                                                       "
  # echo " 29. show_parameters                                                       "
  # echo " 30. show_parameters                                                       "
  # echo " 31. show_parameters                                                       "
  # echo " 32. show_parameters                                                       "
  # echo " 33. show_parameters                                                       "
  # echo " 34. show_parameters                                                       "
  # echo " 35. show_parameters                                                       "
  # echo " 36. show_parameters                                                       "
  # echo " 37. show_parameters                                                       "
  # echo " 38. show_parameters                                                       "
  # echo " 39. show_parameters                                                       "
  # echo " 40. show_parameters                                                       "
  # echo " 41. show_parameters                                                       "
  # echo " 42. show_parameters                                                       "
  # echo " 43. show_parameters                                                       "
  # echo " 44. show_parameters                                                       "
  # echo " 45. show_parameters                                                       "
  # echo " 46. show_parameters                                                       "
  # echo " 47. show_parameters                                                       "
  # echo " 48. show_parameters                                                       "
  # echo " 49. show_parameters                                                       "
  # echo " 50. show_parameters                                                       "
  # echo " 51. show_parameters                                                       "
  # echo " 52. show_parameters                                                       "
  # echo " 53. show_parameters                                                       "
  # echo " 54. show_parameters                                                       "
  # echo " 55. show_parameters                                                       "
  # echo " 56. show_parameters                                                       "
  # echo " 57. show_parameters                                                       "
  # echo " 58. show_parameters                                                       "
  # echo " 59. show_parameters                                                       "
  # echo " 60. show_parameters                                                       "
  # echo " 61. show_parameters                                                       "
  # echo " 62. show_parameters                                                       "
  # echo " 63. show_parameters                                                       "
  # echo " 64. show_parameters                                                       "
  # echo " 65. show_parameters                                                       "
  # echo " 66. show_parameters                                                       "
  # echo " 67. show_parameters                                                       "
  # echo " 68. show_parameters                                                       "
  # echo " 69. show_parameters                                                       "
  # echo " 70. show_parameters                                                       "
  # echo " 71. show_parameters                                                       "
  # echo " 72. show_parameters                                                       "
  # echo " 73. show_parameters                                                       "
  # echo " 74. show_parameters                                                       "
  # echo " 75. show_parameters                                                       "
  # echo " 76. show_parameters                                                       "
  # echo " 77. show_parameters                                                       "
  # echo " 78. show_parameters                                                       "
  # echo " 79. show_parameters                                                       "
  # echo " 80. show_parameters                                                       "
  # echo " 81. show_parameters                                                       "
  # echo " 82. show_parameters                                                       "
  # echo " 83. show_parameters                                                       "
  # echo " 84. show_parameters                                                       "
  # echo " 85. show_parameters                                                       "
  # echo " 86. show_parameters                                                       "
  # echo " 87. show_parameters                                                       "
  # echo " 88. show_parameters                                                       "
  # echo " 89. show_parameters                                                       "
  # echo " 90. show_parameters                                                       "
  # echo " 91. show_parameters                                                       "
  # echo " 92. show_parameters                                                       "
  # echo " 93. show_parameters                                                       "
  # echo " 94. show_parameters                                                       "
  # echo " 95. show_parameters                                                       "
  # echo " 96. show_parameters                                                       "
   echo "~~~~~~~~~~~~~~~~~~~~~"
   echo "99. Exit"
}
# read input from the keyboard and take a action
# invoke the one() when the user select 1 from the menu option.
# invoke the two() when the user select 2 from the menu option.
# Exit when user the user select 100 form the menu option.

read_options(){
	local choice
	read -p "Enter choice [ 1 - 99] " choice
	case $choice in
         0) show_parameters                                                        ;; 
         1) az login  -u bosch.peter@outlook.com                                   ;; 
         2) Create-a-resource-group                                                ;;
         3) Delete-a-resource-group                                                ;;
         4) Create-a-Cosmos-account-for-Gremlin-API                                ;;
         5) Delete-a-Cosmos-account-for-Gremlin-API                                ;;
         6) Create-a-Gremlin-database                                              ;;
         7) Delete-a-Gremlin-database                                              ;;
         8) Create-a-Gremlin-graph                                                 ;;
         9) Delete-a-Gremlin-graph                                                 ;;
         2) show_parameters                                                        ;; 
         3) show_parameters                                                        ;; 
         4) show_parameters                                                        ;; 
         5) show_parameters                                                        ;; 
         6) show_parameters                                                        ;; 
         7) show_parameters                                                        ;; 
         8) show_parameters                                                        ;; 
         9) show_parameters                                                        ;; 
        10) show_parameters                                                        ;; 
        11) show_parameters                                                        ;; 
        12) show_parameters                                                        ;; 
        13) show_parameters                                                        ;; 
        14) show_parameters                                                        ;; 
        15) show_parameters                                                        ;; 
        16) show_parameters                                                        ;; 
        17) show_parameters                                                        ;; 
        18) show_parameters                                                        ;; 
        19) show_parameters                                                        ;; 
        20) show_parameters                                                        ;; 
        21) show_parameters                                                        ;; 
        22) show_parameters                                                        ;; 
        23) show_parameters                                                        ;; 
        24) show_parameters                                                        ;; 
        25) show_parameters                                                        ;; 
        26) show_parameters                                                        ;; 
        27) show_parameters                                                        ;; 
        28) show_parameters                                                        ;; 
        29) show_parameters                                                        ;; 
        30) show_parameters                                                        ;; 
        31) show_parameters                                                        ;; 
        32) show_parameters                                                        ;; 
        33) show_parameters                                                        ;; 
        34) show_parameters                                                        ;; 
        35) show_parameters                                                        ;; 
        36) show_parameters                                                        ;; 
        37) show_parameters                                                        ;; 
        38) show_parameters                                                        ;; 
        39) show_parameters                                                        ;; 
        40) show_parameters                                                        ;; 
        41) show_parameters                                                        ;; 
        42) show_parameters                                                        ;; 
        43) show_parameters                                                        ;; 
        44) show_parameters                                                        ;; 
        45) show_parameters                                                        ;; 
        46) show_parameters                                                        ;; 
        47) show_parameters                                                        ;; 
        48) show_parameters                                                        ;; 
        49) show_parameters                                                        ;; 
        50) show_parameters                                                        ;; 
        51) show_parameters                                                        ;; 
        52) show_parameters                                                        ;; 
        53) show_parameters                                                        ;; 
        54) show_parameters                                                        ;; 
        55) show_parameters                                                        ;; 
        56) show_parameters                                                        ;; 
        57) show_parameters                                                        ;; 
        58) show_parameters                                                        ;; 
        59) show_parameters                                                        ;; 
        60) show_parameters                                                        ;; 
        61) show_parameters                                                        ;; 
        62) show_parameters                                                        ;; 
        63) show_parameters                                                        ;; 
        64) show_parameters                                                        ;; 
        65) show_parameters                                                        ;; 
        66) show_parameters                                                        ;; 
        67) show_parameters                                                        ;; 
        68) show_parameters                                                        ;; 
        69) show_parameters                                                        ;; 
        70) show_parameters                                                        ;; 
        71) show_parameters                                                        ;; 
        72) show_parameters                                                        ;; 
        73) show_parameters                                                        ;; 
        74) show_parameters                                                        ;; 
        75) show_parameters                                                        ;; 
        76) show_parameters                                                        ;; 
        77) show_parameters                                                        ;; 
        78) show_parameters                                                        ;; 
        79) show_parameters                                                        ;; 
        80) show_parameters                                                        ;; 
        81) show_parameters                                                        ;; 
        82) show_parameters                                                        ;; 
        83) show_parameters                                                        ;; 
        84) show_parameters                                                        ;; 
        99) Exit                                                                   ;;
		*) echo -e "${RED}Error...${STD}" && sleep 1
	esac
}

# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
#trap '' SIGINT SIGQUIT SIGTSTP

# -----------------------------------
# Step #4: Main logic - infinite loop
# ------------------------------------
while true
do
	show_menus
	read_options
done
}


##################################################################
# Purpose: Create a resource group
# Arguments:
# Return:
##################################################################
Create-a-resource-group(){
az group create -n $RESOURCEGROUPNAME -l $LOCATION
}

##################################################################
# Purpose: Create a resource group
# Arguments:
# Return:
##################################################################
Delete-a-resource-group(){
az group delete -n $RESOURCEGROUPNAME 
}


##################################################################
# Purpose: Create a Cosmos account for Gremlin API
# Arguments:
# Return:
##################################################################
Create-a-Cosmos-account-for-Gremlin-API(){
 
az cosmosdb create \
    -n $COSMOSDB_ACCOUNTNAME \
    -g $RESOURCEGROUPNAME \
    --capabilities EnableGremlin 
}


##################################################################
# Purpose: Create a Cosmos account for Gremlin API
# Arguments:
# Return:
##################################################################
Delete-a-Cosmos-account-for-Gremlin-API(){
 
az cosmosdb delete \
    -n $COSMOSDB_ACCOUNTNAME \
    -g $RESOURCEGROUPNAME 

}
   



##################################################################
# Purpose: Create a Gremlin database
# Arguments:
# Return:
##################################################################
Create-a-Gremlin-database(){

az cosmosdb gremlin database create \
    -a $COSMOSDB_ACCOUNTNAME \
    -g $RESOURCEGROUPNAME \
    -n $COSMOSDB_DATABASENAME

} 


##################################################################
# Purpose: Create a Gremlin database
# Arguments:
# Return:
##################################################################
Delete-a-Gremlin-database(){

az cosmosdb gremlin database delete \
    -a $COSMOSDB_ACCOUNTNAME \
    -g $RESOURCEGROUPNAME \
    -n $COSMOSDB_DATABASENAME

} 


##################################################################
# Purpose: # Create a Gremlin graph
# Arguments:
# Return:
##################################################################
Create-a-Gremlin-graph(){

# Define the index policy for the graph, include spatial and composite indexes
idxpolicy=$(cat << EOF 
{
    "indexingMode": "consistent", 
    "includedPaths": [
        {"path": "/*"}
    ],
    "excludedPaths": [
        { "path": "/headquarters/employees/?"}
    ],
    "spatialIndexes": [
        {"path": "/*", "types": ["Point"]}
    ],
    "compositeIndexes":[
        [
            { "path":"/name", "order":"ascending" },
            { "path":"/age", "order":"descending" }
        ]
    ]
}
EOF
)
# Persist index policy to json file
echo "$idxpolicy" > "idxpolicy-$UNIQUEID.json"

az cosmosdb gremlin graph create \
    -a $COSMOSDB_ACCOUNTNAME \
    -g $RESOURCEGROUPNAME \
    -d $COSMOSDB_DATABASENAME \
    -n $COSMOSDB_GRAPHNAME \
    -p '/lastName' \
    --throughput 400 \
    --idx @idxpolicy-$UNIQUEID.json

# Clean up temporary index policy file
rm -f "idxpolicy-$UNIQUEID.json"

}


##################################################################
# Purpose: # Create a Gremlin graph
# Arguments:
# Return:
##################################################################
Delete-a-Gremlin-graph(){

az cosmosdb gremlin graph delete \
    -a $COSMOSDB_ACCOUNTNAME \
    -g $RESOURCEGROUPNAME \
    -d $COSMOSDB_DATABASENAME \
    -n $COSMOSDB_GRAPHNAME 

}


#######################
## M A I N
# program starts here actually
#######################

BATCH_START_DATE_TIME=`date +%Y%m%d_%H_%M`
LOG_START_DATE_TIME=`date +%Y%m%d_%H_%M`
LOG_FILE=${LOG_DIR}/LOG_${LOG_START_DATE_TIME}.log
LOG_DIR=${GITHUB_DIR}/LOG_DIR
#create_directories
#create_logdir
clear

echo "***"
echo "***  Welcome to a `uname`   $BATCH_START_DATE_TIME "
echo "***"
echo "***  bfg.bash $@   "

echo -n "Press enter to Continue"

if [ ${MENU} = true ]
 then
clear
while true; do
    read -p "goto MAIN-MENU (y or n)" yn
    case $yn in
          [Yy]* ) show_main_menu ; break;;
          [Nn]* ) echo "N";  break;;
        * ) echo "Please answer yes or no.";;
    esac
done
fi


BATCH_END_DATE_TIME=`date +%Y%m%d_%H_%M`
echo
echo "hope the run will be ok!"
echo


# eof 


# Running some queries in Cosmos
# Now that we have our graph set up, let’s build our people scenario that I referred to earlier. For this, we’ll add some vertices that represent People within our graph. They’ll all have properties for their first name, last name, age, hobby, where they are from and where they live.

# We can add these vertices by running the below queries:
# // Add Will
# g.addV('person').property('firstName', 'Will').property('lastName', 'Velida').property('age', 28).property('userid', 1).property('hobby', 'kayaking').property('from', 'UK').property('lives', 'NZ')
# // Add Gemma
# g.addV('person').property('firstName', 'Gemma').property('lastName', 'Wright').property('age', 30).property('userid', 2).property('hobby', 'hiking').property('from', 'NZ').property('lives', 'NZ')
# // Add Mike
# g.addV('person').property('firstName', 'Mike').property('lastName', 'Smith').property('age', 30).property('userid', 3).property('hobby', 'kayaking').property('from', 'NZ').property('lives', 'NZ')
# // Add Sloan
# g.addV('person').property('firstName', 'Sloan').property('lastName', 'Timms').property('age', 21).property('userid', 4).property('hobby', 'kayaking').property('from', 'UK').property('lives', 'NZ')


# Now we can add some edges that will represent the relationships between our vertices in our People application.
# // Will Knows Gemma
# g.V().hasLabel('person').has('firstName', 'Will').addE('knows').to(g.V().hasLabel('person').has('firstName', 'Gemma'))
# // Sloan Knows Will
# g.V().hasLabel('person').has('firstName', 'Sloan').addE('knows').to(g.V().hasLabel('person').has('firstName', 'Will'))
# // Mike Knows Gemma
# g.V().hasLabel('person').has('firstName', 'Will').addE('knows').to(g.V().hasLabel('person').has('firstName', 'Gemma'))
# Now that we’ve added everything, we can run some simple queries. Let’s run a query that returns all the people in our graph database that have kayaking as a hobby.
# // Select everyone who kayaks as a hobby
# g.V().hasLabel('person').has('hobby', 'kayaking')
# We see the results returned as a graph like so. Three people were returned as results in our query and we can click on each node to see their properties.

# [
#     {
#         "label": "person",
#         "id": "1985d13a-d1e0-470f-833e-869adb9699fa",
#         "firstName": [
#             {
#                 "id": "689dedcf-5f58-46f2-a3a6-00c66923a2f7",
#                 "_value": "Will"
#             }
#         ],
#         "lastName": [
#             {
#                 "id": "5bf8ee22-d5a2-4a81-bcf0-421abd1e3397",
#                 "_value": "Velida"
#             }
#         ],
#         "age": [
#             {
#                 "id": "88f9d692-3b55-4d61-87d9-4600b1d74255",
#                 "_value": 28
#             }
#         ],
#         "userid": [
#             {
#                 "id": "450b6225-7230-47e1-bc14-af0aac626581",
#                 "_value": 1
#             }
#         ],
#         "hobby": "kayaking",
#         "from": [
#             {
#                 "id": "6abac14a-ad39-4fd7-8584-b0658eac7e86",
#                 "_value": "UK"
#             }
#         ],
#         "lives": [
#             {
#                 "id": "b3da26ae-d461-4de4-b8ac-b6470a4cf5a1",
#                 "_value": "NZ"
#             }
#         ],
#         "_rid": "QkNZAJaFcPYBAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYBAAAAAAAAAA==/",
#         "_etag": "\"130bee44-0000-1500-0000-601c03be0000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448702
#     },
#     {
#         "label": "person",
#         "id": "8ab8da8e-2650-4ea2-8d61-3aac59bc1094",
#         "firstName": [
#             {
#                 "id": "7b133d1f-2fc7-40f2-8b35-3e9d1cca7351",
#                 "_value": "Gemma"
#             }
#         ],
#         "lastName": [
#             {
#                 "id": "fb00b00d-cf00-466d-a5b1-f1292a30e45f",
#                 "_value": "Wright"
#             }
#         ],
#         "age": [
#             {
#                 "id": "eca902c8-5a91-46b5-baaa-f725cd1cb381",
#                 "_value": 30
#             }
#         ],
#         "userid": [
#             {
#                 "id": "d59fbf48-4c82-47df-93cc-586dc8d6db4c",
#                 "_value": 2
#             }
#         ],
#         "hobby": "hiking",
#         "from": [
#             {
#                 "id": "8c27ff5f-402b-4073-9897-292544b09362",
#                 "_value": "NZ"
#             }
#         ],
#         "lives": [
#             {
#                 "id": "7f367834-f041-4257-94f3-152384d28ef2",
#                 "_value": "NZ"
#             }
#         ],
#         "_rid": "QkNZAJaFcPYCAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYCAAAAAAAAAA==/",
#         "_etag": "\"130b8345-0000-1500-0000-601c03cf0000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448719
#     },
#     {
#         "label": "person",
#         "id": "fea4d2d5-d2f4-4830-a564-c00b778cb772",
#         "firstName": [
#             {
#                 "id": "b69d818a-0ce7-4681-b27d-e8ee48dc175b",
#                 "_value": "Mike"
#             }
#         ],
#         "lastName": [
#             {
#                 "id": "fd899f5d-17a0-4914-bf04-7e234f749a05",
#                 "_value": "Smith"
#             }
#         ],
#         "age": [
#             {
#                 "id": "bb50705e-ac77-4ef8-ab06-e2a7eeb1d709",
#                 "_value": 30
#             }
#         ],
#         "userid": [
#             {
#                 "id": "cc594695-6163-4c22-a89f-882b8ee19b62",
#                 "_value": 3
#             }
#         ],
#         "hobby": "kayaking",
#         "from": [
#             {
#                 "id": "d719ac56-5a77-433f-9487-774ae8ac3f9b",
#                 "_value": "NZ"
#             }
#         ],
#         "lives": [
#             {
#                 "id": "f3ce99cf-adc5-409f-ae21-2e96d235370e",
#                 "_value": "NZ"
#             }
#         ],
#         "_rid": "QkNZAJaFcPYDAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYDAAAAAAAAAA==/",
#         "_etag": "\"130b2146-0000-1500-0000-601c03e10000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448737
#     },
#     {
#         "label": "person",
#         "id": "c196023b-941b-42f0-b992-dcdc75f9d490",
#         "firstName": [
#             {
#                 "id": "d282d0df-a818-4494-b0f0-a426aae1eecf",
#                 "_value": "Sloan"
#             }
#         ],
#         "lastName": [
#             {
#                 "id": "f0ae2168-4460-4e47-95f5-8aea4d44e3eb",
#                 "_value": "Timms"
#             }
#         ],
#         "age": [
#             {
#                 "id": "3ee7ea4a-d7ed-4a76-80eb-aa86b845c143",
#                 "_value": 21
#             }
#         ],
#         "userid": [
#             {
#                 "id": "4ca9cbe0-eb41-432e-a533-c3c5c4d43f2e",
#                 "_value": 4
#             }
#         ],
#         "hobby": "kayaking",
#         "from": [
#             {
#                 "id": "5ce15088-850a-4e03-9004-f1b2086b3c99",
#                 "_value": "UK"
#             }
#         ],
#         "lives": [
#             {
#                 "id": "5b06f385-1bd2-46ac-967d-7b6f27d3505a",
#                 "_value": "NZ"
#             }
#         ],
#         "_rid": "QkNZAJaFcPYEAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYEAAAAAAAAAA==/",
#         "_etag": "\"130bfd46-0000-1500-0000-601c03f80000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448760
#     },
#     {
#         "label": "knows",
#         "id": "914173d9-8ba7-4d1e-8651-aa74fd612f8e",
#         "_sink": "8ab8da8e-2650-4ea2-8d61-3aac59bc1094",
#         "_sinkLabel": "person",
#         "_sinkPartition": "hiking",
#         "_vertexId": "1985d13a-d1e0-470f-833e-869adb9699fa",
#         "_vertexLabel": "person",
#         "_isEdge": true,
#         "hobby": "kayaking",
#         "_rid": "QkNZAJaFcPYFAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYFAAAAAAAAAA==/",
#         "_etag": "\"130b6748-0000-1500-0000-601c04060000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448774
#     },
#     {
#         "label": "knows",
#         "id": "964bd6c3-886d-4ba0-a6e8-4cd77b9a7776",
#         "_sink": "8ab8da8e-2650-4ea2-8d61-3aac59bc1094",
#         "_sinkLabel": "person",
#         "_sinkPartition": "hiking",
#         "_vertexId": "1985d13a-d1e0-470f-833e-869adb9699fa",
#         "_vertexLabel": "person",
#         "_isEdge": true,
#         "hobby": "kayaking",
#         "_rid": "QkNZAJaFcPYGAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYGAAAAAAAAAA==/",
#         "_etag": "\"130b6948-0000-1500-0000-601c04060000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448774
#     },
#     {
#         "label": "knows",
#         "id": "1062c522-3110-4862-9fa5-8a224295659b",
#         "_sink": "8ab8da8e-2650-4ea2-8d61-3aac59bc1094",
#         "_sinkLabel": "person",
#         "_sinkPartition": "hiking",
#         "_vertexId": "1985d13a-d1e0-470f-833e-869adb9699fa",
#         "_vertexLabel": "person",
#         "_isEdge": true,
#         "hobby": "kayaking",
#         "_rid": "QkNZAJaFcPYHAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYHAAAAAAAAAA==/",
#         "_etag": "\"130ba748-0000-1500-0000-601c040a0000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448778
#     },
#     {
#         "label": "knows",
#         "id": "bfc094f5-adef-4d70-b14b-006e35412263",
#         "_sink": "1985d13a-d1e0-470f-833e-869adb9699fa",
#         "_sinkLabel": "person",
#         "_sinkPartition": "kayaking",
#         "_vertexId": "c196023b-941b-42f0-b992-dcdc75f9d490",
#         "_vertexLabel": "person",
#         "_isEdge": true,
#         "hobby": "kayaking",
#         "_rid": "QkNZAJaFcPYIAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYIAAAAAAAAAA==/",
#         "_etag": "\"130bd74a-0000-1500-0000-601c04210000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448801
#     },
#     {
#         "label": "knows",
#         "id": "4d1b1126-ab5e-4b94-9db2-966bbfdaeefa",
#         "_sink": "8ab8da8e-2650-4ea2-8d61-3aac59bc1094",
#         "_sinkLabel": "person",
#         "_sinkPartition": "hiking",
#         "_vertexId": "1985d13a-d1e0-470f-833e-869adb9699fa",
#         "_vertexLabel": "person",
#         "_isEdge": true,
#         "hobby": "kayaking",
#         "_rid": "QkNZAJaFcPYJAAAAAAAAAA==",
#         "_self": "dbs/QkNZAA==/colls/QkNZAJaFcPY=/docs/QkNZAJaFcPYJAAAAAAAAAA==/",
#         "_etag": "\"130b434c-0000-1500-0000-601c04300000\"",
#         "_attachments": "attachments/",
#         "_ts": 1612448816
#     }
# ]
