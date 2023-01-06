unit Unit3;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ScrollBox,
  FMX.Memo, FMX.Controls.Presentation, FMX.StdCtrls, JSON, FMX.Memo.Types;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Déclarations privées }
    procedure ajout_lignes(lignes: TJSONObject; supprimer: boolean = true);
  public
    { Déclarations publiques }
  end;

var
  Form3: TForm3;

implementation

{$R *.fmx}
{ TForm3 }

procedure TForm3.ajout_lignes(lignes: TJSONObject; supprimer: boolean);
var
  ch1, ch2: string;
  i: integer;
begin
  if assigned(lignes) then
  begin
    for i := 1 to 5 do
    begin
      try
        ch1 := (lignes.GetValue('ligne ' + i.ToString) as TJSONString).Value;
        ch2 := (lignes.GetValue('ligne ' + i.ToString) as TJSONString).ToString;
      except
        ch1 := '';
        ch2 := '';
      end;
      Memo1.Lines.Add(ch1);
      Memo1.Lines.Add(ch2);
    end;
    if supprimer then
      lignes.Free;
  end;
end;

procedure TForm3.Button1Click(Sender: TObject);
var
  jso: TJSONObject;
begin
  jso := TJSONObject.Create;
  jso.AddPair('ligne 1', 'texte 1');
  jso.AddPair('ligne 2', 'texte 2');
  jso.AddPair('ligne 3', 'texte 3');
  jso.AddPair('ligne 4', 'texte 4');
  jso.AddPair('ligne 5', 'texte 5');
  ajout_lignes(jso);
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  ajout_lignes(TJSONObject.Create.AddPair('ligne 1', 'texte 1')
    .AddPair('ligne 2', 'texte 2').AddPair('ligne 3', 'texte 3')
    .AddPair('ligne 4', 'texte 4').AddPair('ligne 5', 'texte 5'));
end;

end.
