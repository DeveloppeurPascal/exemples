program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  unit1 in 'unit1.pas' {Form1},
  u_download in '..\Libraries\librairies\u_download.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
