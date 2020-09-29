program Project2;

uses
  Vcl.Forms,
  problema2Tp1 in 'problema2Tp1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
