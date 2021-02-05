# cosmos_queryforgraph


## azure-cosmos-db-create-graph-dotnet



[azure-cosmos-db-create-graph-dotnet](https://docs.microsoft.com/en-us/azure/cosmos-db/create-graph-dotnet)




https://github.com/Azure-Samples/azure-cosmos-db-graph-gremlindotnet-getting-started/blob/main/GremlinNetSample/Program.cs




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


