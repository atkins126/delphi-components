unit CronometroView;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Dialogs,
  StrUtils;

type
  TCronometroView = class(TLabel)
  private
    FTempoFinal, FTempoDecorrido: TTime;
    FMensagemFinal: String;
    FExibirMensagem: Boolean;
    FZerarPosTermino: Boolean;
    procedure SetTempoFinal(const Value: TTime);
    procedure AtualizarTempo;
    procedure SetMensagemFinal(const Value: String);
    procedure SetExibirMensagem(const Value: Boolean);
    procedure SetZerarPosTrmino(const Value: Boolean);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure Iniciar;
  published
    { Published declarations }
    property TempoFinal: TTime read FTempoFinal write SetTempoFinal;
    property MensagemFinal: String read FMensagemFinal write SetMensagemFinal;
    property ExibirMensagem: Boolean read FExibirMensagem
      write SetExibirMensagem;
    property ZerarPosTermino: Boolean read FZerarPosTermino
      write SetZerarPosTrmino;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Exemplos', [TCronometroView]);
end;

{ TCronometroView }

procedure TCronometroView.AtualizarTempo;
begin
  While FTempoDecorrido < FTempoFinal do
  begin
    FTempoDecorrido := FTempoDecorrido + StrToTime('00:00:01');
    Sleep(1000);
    Caption := TimeToStr(FTempoDecorrido);
    Repaint;
  end;
  if FExibirMensagem then
    MessageDlg(IfThen(FMensagemFinal.Trim <> '', FMensagemFinal,
      'Fim do Tempo!'), mtCustom, [mbOk], 0);

  if ZerarPosTermino then
  begin
    Caption := '00:00:00';
    Repaint;
  end;
end;

procedure TCronometroView.Iniciar;
begin
  FTempoDecorrido := StrToTime('00:00:00');
  AtualizarTempo;
end;

procedure TCronometroView.SetExibirMensagem(const Value: Boolean);
begin
  FExibirMensagem := Value;
end;

procedure TCronometroView.SetMensagemFinal(const Value: String);
begin
  FMensagemFinal := Value;
end;

procedure TCronometroView.SetTempoFinal(const Value: TTime);
begin
  FTempoFinal := Value;
end;

procedure TCronometroView.SetZerarPosTrmino(const Value: Boolean);
begin
  FZerarPosTermino := Value;
end;

end.
