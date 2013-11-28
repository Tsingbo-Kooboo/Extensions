rd Released /Q /S
md Release
md Release\Kooboo.CMS.Toolkit\lib\
md Release\Kooboo.CMS.Toolkit.Controls\lib\
md Release\Kooboo.Core\lib\

del *.log /Q /S

copy "..\Kooboo.CMS.Toolkit\Kooboo.CMS.Toolkit.nuspec" "..\Publish\Release\Kooboo.CMS.Toolkit\Kooboo.CMS.Toolkit.nuspec"
copy "..\Kooboo.CMS.Toolkit.Controls\Kooboo.CMS.Toolkit.Controls.nuspec" "..\Publish\Release\Kooboo.CMS.Toolkit.Controls\Kooboo.CMS.Toolkit.Controls.nuspec"
copy "..\lib\Kooboo.Core.nuspec" "..\Publish\Release\Kooboo.Core\Kooboo.Core.nuspec"

call update_version.vbs

cd..

"C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild" Kooboo.Toolkits.sln /t:rebuild /l:FileLogger,Microsoft.Build.Engine;logfile=Publish\Publish.log;

"C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild" Kooboo.CMS.Toolkit\Kooboo.CMS.Toolkit.csproj /t:ResolveReferences;Compile /p:Configuration=Release logfile=Publish\Publish.log;
"C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild" Kooboo.CMS.Toolkit.Controls\Kooboo.CMS.Toolkit.Controls.csproj /t:ResolveReferences;Compile /p:Configuration=Release logfile=Publish\Publish.log;

cd Kooboo.CMS.Toolkit
copy "bin\Debug\Kooboo.CMS.Toolkit.dll" "..\Publish\Release\Kooboo.CMS.Toolkit\lib\Kooboo.CMS.Toolkit.dll"
cd ..

cd Kooboo.CMS.Toolkit.Controls
copy "bin\Debug\Kooboo.CMS.Toolkit.Controls.dll" "..\Publish\Release\Kooboo.CMS.Toolkit.Controls\lib\Kooboo.CMS.Toolkit.Controls.dll"
cd ..

cd lib 
copy "Kooboo.dll" "..\Publish\Release\Kooboo.Core\lib\Kooboo.dll"
copy "Kooboo.CMS.*.dll" "..\Publish\Release\Kooboo.Core\lib\"
cd ..

cd Publish

nuget pack Release\Kooboo.CMS.Toolkit\Kooboo.CMS.Toolkit.nuspec
nuget setApiKey 12487df2-6ae4-449f-a648-4237aba653b6

nuget pack Release\Kooboo.CMS.Toolkit.Controls\Kooboo.CMS.Toolkit.Controls.nuspec
nuget setApiKey 12487df2-6ae4-449f-a648-4237aba653b6

nuget pack Release\Kooboo.Core\Kooboo.Core.nuspec
nuget setApiKey 12487df2-6ae4-449f-a648-4237aba653b6

move *.nupkg Release\