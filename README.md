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