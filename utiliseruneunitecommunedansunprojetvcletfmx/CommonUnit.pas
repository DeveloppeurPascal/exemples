unit CommonUnit;

interface

// use this code
{$IFDEF VCL}
{$MESSAGE 'Application VCL'}
{$ELSE}
{$IFDEF FMX}
{$MESSAGE 'Application FMX'}
{$ELSE}
{$IFDEF CONSOLE}
{$MESSAGE 'Application console'}
{$ELSE}
{$MESSAGE FATAL 'Please define VCL, FMX or CONSOLE in your project.'}
{$ENDIF}
{$ENDIF}
{$ENDIF}

// or this one
{$IF not (Defined(VCL) or Defined(FMX) or Defined(CONSOLE))}
{$MESSAGE FATAL 'Please define VCL, FMX or CONSOLE in your project.'}
{$ENDIF}

procedure AfficheMessage(texte: string);

implementation

{$IF Defined(VCL)}

uses VCL.Dialogs;
{$ELSEIF Defined(FMX)}

uses FMX.Dialogs;
{$ENDIF}

procedure AfficheMessage(texte: string);
begin
{$IF Defined(VCL) or Defined(FMX)}
  ShowMessage(texte);
{$ELSEIF Defined(CONSOLE)}
  writeln(texte);
{$ENDIF}
end;

end.
