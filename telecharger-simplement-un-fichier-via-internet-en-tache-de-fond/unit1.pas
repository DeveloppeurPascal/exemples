(* C2PP
  ***************************************************************************

  Developpeur Pascal Blog Sample Projects

  Copyright 2015-2025 Patrick Prémartin under AGPL 3.0 license.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
  DEALINGS IN THE SOFTWARE.

  ***************************************************************************

  Author(s) :
  Patrick PREMARTIN

  Site :
  https://developpeur-pascal.fr/

  Project site :
  https://github.com/DeveloppeurPascal/exemples

  ***************************************************************************
  File last update : 2025-02-09T11:12:34.078+01:00
  Signature : 30af0f1c48e4db63f258507ddd2e5907b5da6065
  ***************************************************************************
*)

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
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses u_download, System.IOUtils;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Button1.Enabled := false;
  tdownload_file.download('https://gamolf.fr/images/gamolf-500x500.png',
    tpath.Combine(tpath.GetDocumentsPath(), '__monimage.png'),
    procedure
    begin
      showMessage('Fichier téléchargé');
      Button1.Enabled := true;
    end,
    procedure
    begin
      showMessage('Erreur lors du téléchargement');
      Button1.Enabled := true;
    end);
end;

end.
