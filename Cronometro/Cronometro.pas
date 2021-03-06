unit Cronometro;

interface

uses
  System.SysUtils, System.Classes;

type
  TCronometro = class(TComponent)
  private
    { Private declarations }
    FTempoDecorrido: TTime;
    FTempoFinal: TTime;
    FFimTempo: Boolean;
    procedure SetTempoFinal(const Value: TTime);
  protected
    { Protected declarations }
    function Parar : Boolean; virtual;
    property TempoDecorrido: TTime read FTempoDecorrido;
  public
    { Public declarations }
    procedure Iniciar; virtual;
    function TempoExcedido : Boolean; virtual;
    property FimTempo      : Boolean read FFimTempo;
  published
    { Published declarations }
    property TempoFinal    : TTime read FTempoFinal write SetTempoFinal;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Exemplos', [TCronometro]);
end;

{ TCronometro }

function TCronometro.TempoExcedido : Boolean;
begin
   FTempoDecorrido := FTempoDecorrido + StrToTime('00:00:01');
   Sleep(1000);
   if FTempoDecorrido < FTempoFinal then
   begin
      Result := FFimTempo;
   end
   else
    Result := Parar;
end;

procedure TCronometro.Iniciar;
begin
  FFimTempo := False;
  FTempoDecorrido := StrToTime('00:00:00');
end;

function TCronometro.Parar : Boolean;
begin
  FFimTempo := True;
  Result := FFimTempo;
end;

procedure TCronometro.SetTempoFinal(const Value: TTime);
begin
  FTempoFinal := Value;
end;

end.
