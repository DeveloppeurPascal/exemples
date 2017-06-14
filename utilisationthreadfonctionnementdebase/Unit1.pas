unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    Rectangle5: TRectangle;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
    procedure traitement(rectangle: TRectangle);
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

const
  nb_secondes = 5;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Enabled := false;
  traitement(Rectangle1);
  traitement(Rectangle2);
  traitement(Rectangle3);
  traitement(Rectangle4);
  traitement(Rectangle5);
  Timer1.Enabled := true;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Timer1.Interval := 1000;
  Timer1.Tag := nb_secondes;
  Timer1.Enabled := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if (Timer1.Tag > 0) then
  begin
    Timer1.Tag := Timer1.Tag - 1;
    Button1.Text := Timer1.Tag.ToString;
  end
  else
    Timer1.Enabled := false;
end;

procedure TForm1.traitement(rectangle: TRectangle);
begin
  tthread.CreateAnonymousThread(
    procedure
    var
      couleur: talphacolor;
      i: integer;
    begin
      for i := 1 to nb_secondes * 10 do
      begin
        case random(8) of
          0:
            couleur := talphacolors.red;
          1:
            couleur := talphacolors.orange;
          2:
            couleur := talphacolors.yellow;
          3:
            couleur := talphacolors.green;
          4:
            couleur := talphacolors.blue;
          5:
            couleur := talphacolors.Violet;
          6:
            couleur := talphacolors.Pink;
          7:
            couleur := talphacolors.white;
        else
          couleur := talphacolors.black;
        end;
        tthread.Synchronize(nil,
          procedure
          begin
            rectangle.Fill.Color := couleur;
          end);
        sleep(100); // attente de 0,1 seconde
      end;
    end).Start;
end;

end.
