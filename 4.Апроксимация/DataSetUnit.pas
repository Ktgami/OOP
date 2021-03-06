unit DataSetUnit;

interface

uses ChartUnit;

type
  TDataSet = class(TObject)
  protected
    _Plotted : boolean;
    LineID : integer;
    Chart : TChart;
    procedure SetPlotted(z : boolean);
    procedure BuildLine; virtual; abstract;
  public
    constructor create(Chart : TChart);
    destructor  destroy; override;
    property    Plotted : boolean read _Plotted write SetPlotted;
    procedure   Replot;
end;

implementation


constructor TDataSet.create(Chart : TChart);
begin
  inherited create;
  _Plotted := False;
  self.Chart := chart;
end;

destructor TDataSet.destroy;
begin
  inherited destroy;
end;

procedure TDataSet.SetPlotted(z : boolean);
begin
  _Plotted := z;
  if _Plotted then BuildLine
              else Chart.DelLine(LineID);
end;

procedure TDataSet.Replot;
begin
  if _Plotted then
    begin
      Chart.DelLine(LineID);
      BuildLine;
    end;
end;

end.
