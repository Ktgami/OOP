
unit EditorUnit;

interface

uses StateUnit, Graphics, sState, SceneUnit, PainterUnit;

type
 TEditor = class
   private
     RootState : TRootState;
     Scene : TScene;
     DrawSettings : TDrawSettings;
   public
     constructor Create;
     destructor Destroy; override;
     procedure SetOutPort(Canvas : TCanvas; Width, Height: integer);
     procedure MouseUp(x,y : integer);
     procedure MouseDwn(x,y : integer);
     procedure MouseDrag(x,y : integer);
     procedure ChooseActiveState(sState : TStates);
     procedure Draw;
     procedure SetColor(_FGColor, _BGColor : TColor);
 end;

implementation

{ TEditor }

procedure TEditor.MouseDwn(x,y : integer);
begin
  RootState.MouseDwn(x,y);
end;

procedure TEditor.MouseDrag(x,y : integer);
begin
  RootState.MouseDrag(x,y);
end;

procedure TEditor.MouseUp(x,y : integer);
begin
  RootState.MouseUp(x,y);
end;

procedure TEditor.SetOutPort(Canvas : TCanvas; Width, Height: integer);
begin
  Scene.SetOutPort(Canvas, Width, Height);
end;

procedure TEditor.ChooseActiveState(sState: TStates);
begin
  RootState.ChooseActiveState(sState);
end;

constructor TEditor.Create;
begin
  inherited Create;
  DrawSettings := TDrawSettings.Create;
  Scene := TScene.Create(DrawSettings);
  RootState := TRootState.Create(Scene);

end;

destructor TEditor.Destroy;
begin
  RootState.Destroy;
  Scene.Destroy;
  inherited Destroy;
end;

procedure TEditor.Draw;
begin
  Scene.Draw;
end;

procedure TEditor.SetColor(_FGColor, _BGColor: TColor);
begin
  DrawSettings.FGColor := _FGColor;
  DrawSettings.BGColor := _BGColor;
end;

end.
