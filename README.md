# cosmos_queryforgraph


## azure-cosmos-db-create-graph-dotnet

![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_55.png)

[azure-cosmos-db-create-graph-dotnet](https://docs.microsoft.com/en-us/azure/cosmos-db/create-graph-dotnet)


https://github.com/Azure-Samples/azure-cosmos-db-graph-gremlindotnet-getting-started/blob/main/GremlinNetSample/Program.cs

## git

|I|git clone|
|----|-------------------------|
|ssh|git@github.com:ezahr/cosmos_queryforgraph.git|
|http| https://github.com/ezahr/cosmos_queryforgraph.git |
|gh| gh repo clone ezahr/cosmos_queryforgraph |

## .bash_profile

````
export Host='cosmos-delhaye.gremlin.cosmosdb.azure.com'
export PrimaryKey='FwJGHzl5Mh6oD3idgDqTev5XS7CnEkKjsp24T61tFlzSS2ydpQBRBejhZyHndOFpB8rXOsoNuXLSkSdDHdbAOA=='
export DatabaseName='delhayeDB'
export ContainerName='PeopleGraph'
````

##  cd /Users/osx/Projects/scratch/virtual-insanity/cosmos_queryforgraph/src/GremlinNetSample
##  dotnet new console
##  dotnet add package Gremlin.Net


## GremlinNetSample.csproj 
````
osxs-mbp:src osx$ pwd
/Users/osx/Projects/scratch/virtual-insanity/cosmos_queryforgraph/src
osxs-mbp:src osx$ ls
GremlinNetSample
osxs-mbp:src osx$ cd GremlinNetSample/
osxs-mbp:GremlinNetSample osx$ cat GremlinNetSample.csproj 
<Project Sdk="Microsoft.NET.Sdk">

  <PropertyGroup>
    <OutputType>Exe</OutputType>
    <TargetFramework>netcoreapp3.1</TargetFramework>
  </PropertyGroup>

  <ItemGroup>
    <PackageReference Include="Gremlin.Net" Version="3.4.10" />
  </ItemGroup>

</Project>
osxs-mbp:GremlinNetSample osx$

````

## Program.cs

````
using System;

namespace GremlinNetSample
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
}

````


##  diving-into-gremlin-queries-in-azure-cosmos-db

[diving-into-gremlin-queries-in-azure-cosmos-db-83eb1d7c6350](https://towardsdatascience.com/diving-into-gremlin-queries-in-azure-cosmos-db-83eb1d7c6350)

## Vertex   Hoeken

````
# Add Will Velida
g.addV('person').property('firstName', 'Will').property('lastName', 'Velida').property('age', 28).property('hairColor', 'blonde').property('userId', 1).property('pk', 'pk')
g.addV('person').property('firstName', 'Alex').property('lastName', 'Smith').property('age', 22).property('hairColor', 'brown').property('userId', 2).property('pk', 'pk')
g.addV('person').property('firstName', 'Mike').property('lastName', 'Jones').property('hairColor', 'black').property('userId', 2).property('pk', 'pk')
g.addV('person').property('firstName', 'Sarah').property('lastName', 'Smith').property('hairColor', 'blonde').property('userId', 4).property('pk', 'pk')
g.addV('person').property('firstName', 'Debbie').property('lastName', 'Stevens').property('hairColor', 'black').property('age', 57).property('userId', 5).property('pk', 'pk')


````

## Edges Randen

````
g.V().hasLabel('person').has('firstName', 'Will').addE('knows').to(g.V().hasLabel('person').has('firstName', 'Alex'))
g.V().hasLabel('person').has('firstName', 'Alex').addE('knows').to(g.V().hasLabel('person').has('firstName', 'Mike'))

````

## Let’s examine the new Gremlin queries:


## g.V().hasLabel('person').has('firstName', 'Mike').property('userId', 3



## g.V().hasLabel('person').has('age', lt(30))



## g.V().hasLabel('person').has('age', lt(30)).values('firstName')




## g.V().hasLabel('person').has('firstName', 'Alex').outE('knows').inV().hasLabel('person')


```
g.V().hasLabel('person').has('firstName', 'Alex').addE('knows').to(g.V().hasLabel('person').has('firstName', 'Mike'))

```

## Program.cs first draft
````



using System;
using System.Collections.Generic;
using System.Net.WebSockets;
using System.Threading.Tasks;
using Gremlin.Net.Driver;
using Gremlin.Net.Driver.Exceptions;
using Gremlin.Net.Structure.IO.GraphSON;
using Newtonsoft.Json;

namespace GremlinNetSample
{
    /// <summary>
    /// Sample program that shows how to get started with the Graph (Gremlin) APIs for Azure Cosmos DB using the open-source connector Gremlin.Net
    /// </summary>
    class Program
    {
        // Azure Cosmos DB Configuration variables
        // Replace the values in these variables to your own.
        // <configureConnectivity>
   
        //export Host='cosmos-delhaye.gremlin.cosmosdb.azure.com'
        //export PrimaryKey='FwJGHzl5Mh6oD3idgDqTev5XS7CnEkKjsp24T61tFlzSS2ydpQBRBejhZyHndOFpB8rXOsoNuXLSkSdDHdbAOA=='
        //export DatabaseName='delhayeDB'
        //export ContainerName='PeopleGraph
        
        
        private static string Host => Environment.GetEnvironmentVariable("Host") ?? throw new ArgumentException("Missing env var: Host");
        private static string PrimaryKey => Environment.GetEnvironmentVariable("PrimaryKey") ?? throw new ArgumentException("Missing env var: PrimaryKey");
        private static string Database => Environment.GetEnvironmentVariable("DatabaseName") ?? throw new ArgumentException("Missing env var: DatabaseName");
        private static string Container => Environment.GetEnvironmentVariable("ContainerName") ?? throw new ArgumentException("Missing env var: ContainerName");

        private static bool EnableSSL
        {
            get
            {
                if (Environment.GetEnvironmentVariable("EnableSSL") == null)
                {
                    return true;
                }

                if (!bool.TryParse(Environment.GetEnvironmentVariable("EnableSSL"), out bool value))
                {
                    throw new ArgumentException("Invalid env var: EnableSSL is not a boolean");
                }

                return value;
            }
        }

        private static int Port
        {
            get
            {
                if (Environment.GetEnvironmentVariable("Port") == null)
                {
                    return 443;
                }

                if (!int.TryParse(Environment.GetEnvironmentVariable("Port"), out int port))
                {
                    throw new ArgumentException("Invalid env var: Port is not an integer");
                }

                return port;
            } 
        }

        // </configureConnectivity>

        // Gremlin queries that will be executed.
        // <defineQueries>
        private static Dictionary<string, string> gremlinQueries = new Dictionary<string, string>
        {
        //     { "Cleanup",        "g.V().drop()" },
        //     { "AddVertex 1",     "g.addV('person').property('firstName', 'Will').property('lastName', 'Velida').property('age', 28).property('hairColor', 'blonde').property('userId', 1).property('pk', 'pk')" },
        //     { "AddVertex 2",     "g.addV('person').property('firstName', 'Alex').property('lastName', 'Smith').property('age', 22).property('hairColor', 'brown').property('userId', 2).property('pk', 'pk')" },
        //     { "AddVertex 3",     "g.addV('person').property('firstName', 'Mike').property('lastName', 'Jones').property('hairColor', 'black').property('userId', 2).property('pk', 'pk')" },
        //     { "AddVertex 4",     "g.addV('person').property('firstName', 'Sarah').property('lastName', 'Smith').property('hairColor', 'blonde').property('userId', 4).property('pk', 'pk')" },
        //     { "AddVertex 5",     "g.addV('person').property('firstName', 'Debbie').property('lastName', 'Stevens').property('hairColor', 'black').property('age', 57).property('userId', 5).property('pk', 'pk')" },
            // { "AddEdge 1",       "g.V().hasLabel('person').has('firstName', 'Will').addE('knows').to(g.V().hasLabel('person').has('firstName', 'Alex'))" },
            // { "AddEdge 2",       "g.V().hasLabel('person').has('firstName', 'Alex').addE('knows').to(g.V().hasLabel('person').has('firstName', 'Mike')" },
       
        

      //      { "AddVertex 1",    "g.addV('person').property('id', 'thomas').property('firstName', 'Thomas').property('age', 44).property('pk', 'pk')" },
      //      { "AddVertex 2",    "g.addV('person').property('id', 'mary').property('firstName', 'Mary').property('lastName', 'Andersen').property('age', 39).property('pk', 'pk')" },
      //      { "AddVertex 3",    "g.addV('person').property('id', 'ben').property('firstName', 'Ben').property('lastName', 'Miller').property('pk', 'pk')" },
      //      { "AddVertex 4",    "g.addV('person').property('id', 'robin').property('firstName', 'Robin').property('lastName', 'Wakefield').property('pk', 'pk')" },
      //      { "AddEdge 1",      "g.V('thomas').addE('knows').to(g.V('mary'))" },
      //      { "AddEdge 2",      "g.V('thomas').addE('knows').to(g.V('ben'))" },
      //      { "AddEdge 3",      "g.V('ben').addE('knows').to(g.V('robin'))" },
       //     { "UpdateVertex",   "g.V('thomas').property('age', 44)" },
              { "CountVertices",  "g.V().count()" },
              { "Filter Range",   "g.V().hasLabel('person').has('age', gt(40))" },
              { "Project",        "g.V().hasLabel('person').values('firstName')" },
              { "Traverse",       "g.V().hasLabel('person').has('firstName', 'Alex').outE('knows').inV().hasLabel('person')" },
       //     { "Sort",           "g.V().hasLabel('person').order().by('firstName', decr)" },
       //     { "Traverse",       "g.V('thomas').out('knows').hasLabel('person')" },
       //     { "Traverse 2x",    "g.V('thomas').out('knows').hasLabel('person').out('knows').hasLabel('person')" },
       //     { "Loop",           "g.V('thomas').repeat(out()).until(has('id', 'robin')).path()" },
       //     { "DropEdge",       "g.V('thomas').outE('knows').where(inV().has('id', 'mary')).drop()" },
       //     { "CountEdges",     "g.E().count()" },
       //     { "DropVertex",     "g.V('thomas').drop()" },
        };
        // </defineQueries>

        // Starts a console application that executes every Gremlin query in the gremlinQueries dictionary. 
        static void Main(string[] args)
        {
            // <defineClientandServerObjects>
            string containerLink = "/dbs/" + Database + "/colls/" + Container;
            Console.WriteLine($"Connecting to: host: {Host}, port: {Port}, container: {containerLink}, ssl: {EnableSSL}");
            var gremlinServer = new GremlinServer(Host, Port, enableSsl: EnableSSL, 
                                                    username: containerLink, 
                                                    password: PrimaryKey);

            ConnectionPoolSettings connectionPoolSettings = new ConnectionPoolSettings()
            {
                MaxInProcessPerConnection = 10,
                PoolSize = 30, 
                ReconnectionAttempts= 3,
                ReconnectionBaseDelay = TimeSpan.FromMilliseconds(500)
            };

            var webSocketConfiguration =
                new Action<ClientWebSocketOptions>(options =>
                {
                    options.KeepAliveInterval = TimeSpan.FromSeconds(10);
                });


            using (var gremlinClient = new GremlinClient(
                gremlinServer, 
                new GraphSON2Reader(), 
                new GraphSON2Writer(), 
                GremlinClient.GraphSON2MimeType, 
                connectionPoolSettings, 
                webSocketConfiguration))
            {
            // </defineClientandServerObjects>
                
                // <executeQueries>
                foreach (var query in gremlinQueries)
                {
                    Console.WriteLine(String.Format("Running this query: {0}: {1}", query.Key, query.Value));

                    // Create async task to execute the Gremlin query.
                    var resultSet = SubmitRequest(gremlinClient, query).Result;
                    if (resultSet.Count > 0)
                    {
                        Console.WriteLine("\tResult:");
                        foreach (var result in resultSet)
                        {
                            // The vertex results are formed as Dictionaries with a nested dictionary for their properties
                            string output = JsonConvert.SerializeObject(result);
                            Console.WriteLine($"\t{output}");
                        }
                        Console.WriteLine();
                    }

                    // Print the status attributes for the result set.
                    // This includes the following:
                    //  x-ms-status-code            : This is the sub-status code which is specific to Cosmos DB.
                    //  x-ms-total-request-charge   : The total request units charged for processing a request.
                    //  x-ms-total-server-time-ms   : The total time executing processing the request on the server.
                    // ff niet PrintStatusAttributes(resultSet.StatusAttributes);
                    Console.WriteLine();
                }
                // </executeQueries>
            }

            // Exit program
            Console.WriteLine("Done. Press any key to exit...");
            Console.ReadLine();
        }

        private static Task<ResultSet<dynamic>> SubmitRequest(GremlinClient gremlinClient, KeyValuePair<string, string> query)
        {
            try
            {
                return gremlinClient.SubmitAsync<dynamic>(query.Value);
            }
            catch (ResponseException e)
            {
                Console.WriteLine("\tRequest Error!");

                // Print the Gremlin status code.
                Console.WriteLine($"\tStatusCode: {e.StatusCode}");

                // On error, ResponseException.StatusAttributes will include the common StatusAttributes for successful requests, as well as
                // additional attributes for retry handling and diagnostics.
                // These include:
                //  x-ms-retry-after-ms         : The number of milliseconds to wait to retry the operation after an initial operation was throttled. This will be populated when
                //                              : attribute 'x-ms-status-code' returns 429.
                //  x-ms-activity-id            : Represents a unique identifier for the operation. Commonly used for troubleshooting purposes.
               
                 PrintStatusAttributes(e.StatusAttributes);
                 Console.WriteLine($"\t[\"x-MS-retry-after-ms\"] : { GetValueAsString(e.StatusAttributes, "x-ms-retry-after-ms")}");
                 Console.WriteLine($"\t[\"x-MS-activity-id\"] : { GetValueAsString(e.StatusAttributes, "x-ms-activity-id")}");

                throw;
            }
        }

        private static void PrintStatusAttributes(IReadOnlyDictionary<string, object> attributes)
        {
            Console.WriteLine($"\tStatusAttributes:");
            Console.WriteLine($"\t[\"x-ms-status-code\"] : { GetValueAsString(attributes, "x-ms-status-code")}");
            Console.WriteLine($"\t[\"x-ms-total-server-time-ms\"] : { GetValueAsString(attributes, "x-ms-total-server-time-ms")}");
            Console.WriteLine($"\t[\"x-ms-total-request-charge\"] : { GetValueAsString(attributes, "x-ms-total-request-charge")}");
        }

        public static string GetValueAsString(IReadOnlyDictionary<string, object> dictionary, string key)
        {
            return JsonConvert.SerializeObject(GetValueOrDefault(dictionary, key));
        }

        public static object GetValueOrDefault(IReadOnlyDictionary<string, object> dictionary, string key)
        {
            if (dictionary.ContainsKey(key))
            {
                return dictionary[key];
            }

            return null;
        }
    }
}
````


![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_00.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_01.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_02.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_03.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_04.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_05.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_06.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_07.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_08.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_09.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_10.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_11.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_12.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_13.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_14.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_15.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_16.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_17.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_18.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_19.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_20.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_21.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_22.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_23.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_24.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_25.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_26.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_27.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_28.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_29.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_30.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_31.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_32.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_33.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_34.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_35.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_36.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_37.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_38.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_39.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_40.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_41.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_42.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_43.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_44.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_45.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_46.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_47.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_48.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_49.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_50.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_51.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_52.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_53.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_54.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_55.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_56.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_57.png)
![hoeken en randen](.//pictures/hello_vertexes_and_edges_nice_to_see_you_58.png)

