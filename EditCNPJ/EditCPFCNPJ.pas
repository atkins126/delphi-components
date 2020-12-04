unit EditCPFCNPJ;

interface

uses
  System.SysUtils, System.Classes, Vcl.Controls, Vcl.StdCtrls, Vcl.Mask;

type
  TPessoa = (pJuridica,pFisica);
  TEditCPFCNPJ = class(TMaskEdit)
  private
    FTipoPessoa: TPessoa;
    procedure SetTipoPessoa(const Value: TPessoa);
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    property TipoPessoa : TPessoa read FTipoPessoa write SetTipoPessoa;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Exemplos', [TEditCPFCNPJ]);
end;

{ TEditCPFCNPJ }

procedure TEditCPFCNPJ.SetTipoPessoa(const Value: TPessoa);
begin
  FTipoPessoa := Value;

  case Value of
    pJuridica: EditMask := '99.999.999/9999-99;1;_' ;
    pFisica:   EditMask := '999.999.999-99;1;_';
  end;
end;

end.
