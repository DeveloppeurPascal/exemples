program Project3;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  CommonUnit in '..\CommonUnit.pas';

begin
  try
    AfficheMessage('Hello World');

    while true do;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
