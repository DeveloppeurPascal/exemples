unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.Layouts;

type
  TForm1 = class(TForm)
    btnFuture: TButton;
    ProgressBar1: TProgressBar;
    FloatAnimation1: TFloatAnimation;
    Memo1: TMemo;
    GridLayout1: TGridLayout;
    btnThread: TButton;
    btnAniIndicator: TButton;
    procedure btnFutureClick(Sender: TObject);
    procedure GridLayout1Resize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnThreadClick(Sender: TObject);
    procedure btnAniIndicatorClick(Sender: TObject);
  private
    { D�clarations priv�es }
    procedure CalculLaChaineUserFriendly(Parent: TFmxObject;
      FinTraitement: tproc<string>);
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses System.Threading;

procedure TForm1.btnThreadClick(Sender: TObject);
var
  Resultat: string;
begin
  Memo1.Lines.Add('btnThreadClick d�marr�e');
  application.ProcessMessages;
  // lance le calcul en t�che de fond
  tthread.CreateAnonymousThread(
    procedure
    begin
      sleep(5000);
      Resultat := 'Hello World btnThreadClick';
    end).Start;
  // affiche la variable avant la fin du calcul
  Memo1.Lines.Add('btnThreadClick r�sultat : ' + Resultat);
  application.ProcessMessages;
  Memo1.Lines.Add('btnThreadClick termin�e');
  application.ProcessMessages;
end;

procedure TForm1.CalculLaChaineUserFriendly(Parent: TFmxObject;
FinTraitement: tproc<string>);
var
  logoAttente: taniindicator;
begin
  Memo1.Lines.Add('CalculLaChaineUserFriendly d�marr�e');
  application.ProcessMessages;
  logoAttente := taniindicator.Create(Parent);
  try
    logoAttente.Parent := Parent;
    logoAttente.Align := TAlignLayout.Client;
    logoAttente.Enabled := true;
    tthread.CreateAnonymousThread(
      procedure
      var
        Resultat: string;
      begin
        sleep(5000);
        Resultat := 'Hello World CalculLaChaineUserFriendly';
        tthread.Synchronize(nil,
          procedure
          begin
            logoAttente.Free;
            if assigned(FinTraitement) then
              FinTraitement(Resultat);
          end);
      end).Start;
  except
    logoAttente.Free;
  end;
  Memo1.Lines.Add('CalculLaChaineUserFriendly termin�e');
  application.ProcessMessages;
end;

procedure TForm1.btnAniIndicatorClick(Sender: TObject);
begin
  Memo1.Lines.Add('btnAniIndicatorClick d�marr�e');
  application.ProcessMessages;
  btnAniIndicator.Enabled := false;
  CalculLaChaineUserFriendly(btnAniIndicator,
    procedure(Resultat: string)
    begin
      Memo1.Lines.Add('btnAniIndicatorClick r�sultat : ' + Resultat);
      application.ProcessMessages;
      btnAniIndicator.Enabled := true;
    end);
  Memo1.Lines.Add('btnAniIndicatorClick termin�e');
  application.ProcessMessages;
end;

procedure TForm1.btnFutureClick(Sender: TObject);
var
  ChaineCalculee: IFuture<string>;
  Resultat: string;
begin
  Memo1.Lines.Add('btnFutureClick d�marr�e');
  application.ProcessMessages;
  // lance le thread et effectue le calcul demand�
  ChaineCalculee := ttask.Future<string>(
    function: string
    begin
      sleep(5000);
      Result := 'Hello World btnFutureClick';
    end);
  // traitement normal
  Memo1.Lines.Add('btnFutureClick calcul lanc�');
  application.ProcessMessages;
  // bloque le processus en cours jusqu'� avoir la r�ponse
  Resultat := ChaineCalculee.Value;
  // reprend son traitement normal
  Memo1.Lines.Add('btnFutureClick r�sultat : ' + Resultat);
  application.ProcessMessages;
  Memo1.Lines.Add('btnFutureClick termin�e');
  application.ProcessMessages;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  GridLayout1Resize(Sender);
end;

procedure TForm1.GridLayout1Resize(Sender: TObject);
begin
  GridLayout1.ItemWidth := GridLayout1.Width / GridLayout1.ChildrenCount;
end;

end.
