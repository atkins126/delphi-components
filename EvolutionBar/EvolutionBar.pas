unit EvolutionBar;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, System.UITypes,Vcl.Graphics ;

type
  TTipo = (tpPorcentagem,tpTexto);
  TEvolutionBar = class(TCustomControl)
  private
    { Private declarations }
    Pos : Integer;
    FTexto : String;
    FShowTexto : Boolean;
    FTipoTexto : TTipo;
    FValorMin  : Integer;
    FValorMax  : Integer;
    FPosicao   : Integer;
    FCorEvolucao : TColor;
    FFonteTexto : TFont;
    FCorFundo : TColor;
    procedure SetTexto(const Value: String);
    procedure SetTipoTexto(const Value: TTipo);
    procedure SetShowTexto(const Value: Boolean);
    procedure SetValorMax(const Value: Integer);
    procedure SetValorMin(const Value: Integer);
    procedure SetCorEvolucao(const Value: TColor);
    procedure SetCorFundo(const Value: TColor);
    procedure SetFonteTexto(const Value: TFont);
    procedure SetPosicao(const Value: Integer);


  protected
    { Protected declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; Override;

    procedure Paint; Override;
  published
    { Published declarations }
    property Texto : String read FTexto write SetTexto;
    property TipoTexto : TTipo read FTipoTexto write SetTipoTexto;
    property ShowTexto : Boolean read FShowTexto write SetShowTexto;
    property ValorMin : Integer read FValorMin write SetValorMin;
    property ValorMax : Integer read FValorMax write SetValorMax;
    property Posicao : Integer read FPosicao write SetPosicao;
    property CorEvolucao : TColor read FCorEvolucao write SetCorEvolucao;
    property CorFundo : TColor read FCorFundo write SetCorFundo;
    property FonteTexto : TFont read FFonteTexto write SetFonteTexto;
    property Visible;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Exemplos', [TEvolutionBar]);
end;

{ TEvolutionBar }

constructor TEvolutionBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width  := 150;
  Height := 16;
  Pos    := 0;

  FShowTexto   := True;
  FCorEvolucao := clBlue;
  FCorFundo    := clWhite;
  FFonteTexto  := TFont.Create();
end;

destructor TEvolutionBar.Destroy;
begin
  FFonteTexto.Free;
  inherited;
end;

procedure TEvolutionBar.Paint;
var LargText, AltText, CoordX, CoordY : Integer;
    aTexto : String;
begin
  inherited;
  aTexto := '';
  CoordX := 0;
  CoordY := 0;
  with Canvas do
  begin
    Brush.Color := FCorFundo;
    Rectangle(0,0,Width,Height);

    if FPosicao >  0 then
    begin
      Brush.Color := FCorEvolucao;
      Rectangle(0,0,((Pos * Width) div 100), Height);
    end;

    if FShowTexto then
    begin
      if FTipoTexto = tpTexto then
        aTexto := FTexto
      else
        aTexto := IntToStr(Pos) + '%';

      LargText := TextWidth(aTexto);
      AltText  := TextHeight(aTexto);
      CoordX   := (Width - LargText)div 2;
      CoordY   := (Height - AltText) div 2;
    end;

    Font.Color   := FFonteTexto.Color;
    Font.Size    := FFonteTexto.Size;
    Font.Style   := FFonteTexto.Style;
    Font.Name    := FFonteTexto.Name;
    Font.Height  := FFonteTexto.Height;
    Font.Charset := FFonteTexto.Charset;
    Font.Pitch   := FFonteTexto.Pitch;

    Brush.Style := bsClear;
    TextOut(CoordX,CoordY,aTexto);
  end;
end;

procedure TEvolutionBar.SetCorEvolucao(const Value: TColor);
begin
  if FCorEvolucao <> Value then
  begin
    FCorEvolucao := Value;
    Repaint;
  end;
end;

procedure TEvolutionBar.SetCorFundo(const Value: TColor);
begin
  if FCorFundo <> Value then
  begin
    FCorFundo := Value;
    Repaint;
  end;
end;

procedure TEvolutionBar.SetFonteTexto(const Value: TFont);
begin
  FFonteTexto := Value;
  Repaint;
end;

procedure TEvolutionBar.SetPosicao(const Value: Integer);
begin
  if FPosicao <> Value then
  begin
    if (Value >= FValorMin) and (Value <= FValorMax) then
    begin
      Pos := ((Value * 100) div FValorMax);
      FPosicao := Value;
      Repaint;
    end;
  end;
end;

procedure TEvolutionBar.SetShowTexto(const Value: Boolean);
begin
  if FShowTexto <> Value then
  begin
    FShowTexto := Value;
    Repaint
  end;
end;

procedure TEvolutionBar.SetTexto(const Value: String);
begin
  if FTexto <> Value then
  begin
    FTexto := Value;
    Repaint;
  end;
end;

procedure TEvolutionBar.SetTipoTexto(const Value: TTipo);
begin
  if FTipoTexto <> Value then
  begin
    FTipoTexto := Value;
    Repaint;
  end;
end;

procedure TEvolutionBar.SetValorMax(const Value: Integer);
begin
  if FValorMax <> Value then
  begin
    if (Value >= FValorMin) then
    begin
      FValorMax := Value;
      if (Value < FPosicao) then
        FPosicao := Value;
      Pos := ((FPosicao * 100) div Value);
      Repaint;
    end;
  end;
end;

procedure TEvolutionBar.SetValorMin(const Value: Integer);
begin
  if FValorMin <> Value then
  begin
    if (Value >= 0) and (Value < FValorMax) then
    begin
      FValorMin := Value;
      FPosicao  := Value;
      Pos := ((FPosicao * 100) div FValorMax);
      Repaint;
    end;
  end;
end;

end.
