unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses u_download, System.IOUtils;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Enabled := false;
  tdownload_file.download('http://gamolf.fr/images/gamolf-500x500.psng',
    tpath.Combine(tpath.GetDocumentsPath(), '__monimage.png'),
    procedure
    begin
      showMessage('Fichier t�l�charg�');
      Button1.Enabled := true;
    end,
    procedure
    begin
      showMessage('Erreur lors du t�l�chargement');
      Button1.Enabled := true;
    end);
end;

end.
