unit UFloatPanel;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.ExtCtrls, Messages,Windows;

type
  TFloatPanel = class(TPanel)
  private
    FMovimentDesign: Boolean;
    procedure SetMovimentDesign(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    procedure WM_MouseDown(var Msg : TMsg); message WM_LBUTTONDOWN;
  published
    property MovimentDesign : Boolean read FMovimentDesign write SetMovimentDesign;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Exemplos', [TFloatPanel]);
end;

{ TFloatPanel }

procedure TFloatPanel.SetMovimentDesign(const Value: Boolean);
begin
  FMovimentDesign := Value;
end;

procedure TFloatPanel.WM_MouseDown(var Msg: TMsg);
begin
  if MovimentDesign then
  begin
    releasecapture;
    PostMessage(Handle,WM_SYSCOMMAND,$F012,0);
  end;
end;

end.
