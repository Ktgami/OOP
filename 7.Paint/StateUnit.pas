unit StateUnit;



interface

 uses SceneUnit, FigureUnit, sState;

type

 TState = class
 protected
   Scene : TScene;
 public
   constructor Create(Scene : TScene);
   procedure MouseDwn(x,y : integer); virtual;
   procedure MouseUp(x,y : integer); virtual;
   procedure MouseDrag(x,y : integer); virtual;
 end;

 TComplexState = class(TState)
 private
   ActiveState : TState;
 public
   procedure MouseDwn(x,y : integer); override;
   procedure MouseUp(x,y : integer); override;
   procedure MouseDrag(x,y : integer); override;
   procedure SetActiveState(State: TState);
 end;

 TOwnedSimpleState = class(TState)
 protected
   OwnerState : TComplexState;
 public
   constructor Create(Scene : TScene; OwnerState : TComplexState);
 end;

 TFigureDealState = class(TOwnedSimpleState)
 protected
   Figure : TFigure;
 public
   procedure SetFigure(Figure : TFigure);
 end;

 TDragState = class(TFigureDealState)
 private
   ReturnState : TState;
 public
   constructor Create(Scene : TScene; OwnerState : TComplexState; ReturnState : TState);
   procedure MouseUp(x,y : integer); override;
   procedure MouseDrag(x,y : integer); override;
 end;

 TFigureCreateState = class(TFigureDealState)
 protected
   DragState : TState;
   procedure CreateFigure(x,y : integer); virtual; abstract;
 public
   procedure MouseDwn(x,y : integer); override;
   procedure SetDragSt(DragState : TState);
 end;

 TRectCreateState = class(TFigureCreateState)
 protected
   procedure CreateFigure(x,y : integer); override;
 end;

 TRectState = class(TComplexState)
 private
   RectCreateState : TRectCreateState;
   DragState : TDragState;
 public
   constructor Create(Scene : TScene);
   destructor Destroy; override;
 end;
{--------------------------------------------------------------------}
 TLineCreateState = class(TFigureCreateState)
 protected
   procedure CreateFigure(x,y : integer); override;
 end;

 TLineState = class(TComplexState)
 private
   LineCreateState : TLineCreateState;
   DragState : TDragState;
 public
   constructor Create(Scene : TScene);
   destructor Destroy; override;
 end;

 TEllpCreateState = class(TFigureCreateState)
 protected
   procedure CreateFigure(x,y : integer); override;
 end;

 TEllpState = class(TComplexState)
 private
   EllpCreateState : TEllpCreateState;
   DragState : TDragState;
 public
   constructor Create(Scene : TScene);
   destructor Destroy; override;
 end;

 TPenCreateState = class(TFigureCreateState)
 protected
   procedure CreateFigure(x,y : integer); override;
 end;

 TPenState = class(TComplexState)
 private
   PenCreateState : TPenCreateState;
   DragState : TDragState;
 public
   constructor Create(Scene : TScene);
   destructor Destroy; override;
 end;

 TErasCreateState = class(TFigureCreateState)
 protected
   procedure CreateFigure(x,y : integer); override;
 end;

 TErasState = class(TComplexState)
 private
   ErasCreateState : TErasCreateState;
   DragState : TDragState;
 public
   constructor Create(Scene : TScene);
   destructor Destroy; override;
 end;

 TDragSprayState = class(TDragState)
 public
   procedure MouseDwn(x,y : integer); override;
 end;

 TSprayCreateState = class(TFigureCreateState)
 protected
   procedure CreateFigure(x,y : integer); override;
 end;

 TSprayState = class(TComplexState)
 private
   SprayCreateState : TSprayCreateState;
   DragSprayState : TDragSprayState;
 public
   constructor Create(Scene : TScene);
   destructor Destroy; override;
 end;

 TFillState = class(TState)
 private
    Figure : TFillFigure;
    ActiveState : TState;
 public
   constructor Create(Scene : TScene);
   procedure MouseUp(x,y : integer); override;
 end;
 {---------------------------------------------------------------------}
 TRootState = class(TComplexState)
 private
   EmptyState  : TState;
   RectState   : TRectState;
   LineState   : TLineState;
   EllpState   : TEllpState;
   PenState    : TPenState;
   SprayState  : TSprayState;
   ErasState   : TErasState;
   FillState   : TFillState;
 public
   Constructor Create(Scene : TScene);
   destructor Destroy; override;
   procedure ChooseActiveState(sState : TStates);
 end;

implementation

{ TState }

constructor TState.Create(Scene: TScene);
begin
  inherited Create;
  self.Scene := Scene;
end;

procedure TState.MouseDrag(x, y: integer);
begin
end;

procedure TState.MouseDwn(x, y: integer);
begin
end;

procedure TState.MouseUp(x, y: integer);
begin
end;

{ TComplexState }

procedure TComplexState.MouseDrag(x, y: integer);
begin
  if ActiveState <> nil then ActiveState.MouseDrag(x, y);
end;

procedure TComplexState.MouseDwn(x, y: integer);
begin
  if ActiveState <> nil then ActiveState.MouseDwn(x, y);
end;

procedure TComplexState.MouseUp(x, y: integer);
begin
  if ActiveState <> nil then ActiveState.MouseUp(x, y);
end;

procedure TComplexState.SetActiveState(State: TState);
begin
  ActiveState := State;
end;

{ TFigureDealState }

procedure TFigureDealState.SetFigure(Figure: TFigure);
begin
  self.Figure := Figure;
end;

{ TOwnedSimpleState }

constructor TOwnedSimpleState.Create(Scene : TScene; OwnerState: TComplexState);
begin
  inherited Create(Scene);
  self.OwnerState := OwnerState;
end;

{ TDragState }

constructor TDragState.Create(Scene : TScene; OwnerState: TComplexState;
  ReturnState: TState);
begin
  inherited Create(Scene, OwnerState);
  self.ReturnState := ReturnState;
end;

procedure TDragState.MouseDrag(x, y: integer);
begin
  Figure.Drag(x,y);
  Scene.Draw
end;

procedure TDragState.MouseUp(x, y: integer);
begin
  Figure.BuiltIn := true;
  Scene.Draw;
  Scene.SetFigure(nil);
  Figure.Destroy;
  OwnerState.SetActiveState(ReturnState);
end;

{ TRectState }

constructor TRectState.Create(Scene : TScene);
begin
  inherited Create(Scene);
  RectCreateState := TRectCreateState.Create(Scene, self);
  DragState := TDragState.Create(Scene, self, RectCreateState);
  RectCreateState.SetDragSt(DragState);
  ActiveState := RectCreateState;
end;

destructor TRectState.Destroy;
begin
  DragState.Destroy;
  RectCreateState.Destroy;
  inherited Destroy;
end;

{ TLineState }

constructor TLineState.Create(Scene: TScene);
begin
  inherited Create(Scene);
  LineCreateState := TLineCreateState.Create(Scene, self);
  DragState := TDragState.Create(Scene, self, LineCreateState);
  LineCreateState.SetDragSt(DragState);
  ActiveState := LineCreateState;
end;

destructor TLineState.Destroy;
begin
  DragState.Destroy;
  LineCreateState.Destroy;
  inherited Destroy;
end;

{ TEllpState }

constructor TEllpState.Create(Scene: TScene);
begin
  inherited Create(Scene);
  EllpCreateState := TEllpCreateState.Create(Scene, self);
  DragState := TDragState.Create(Scene, self, EllpCreateState);
  EllpCreateState.SetDragSt(DragState);
  ActiveState := EllpCreateState;
end;

destructor TEllpState.Destroy;
begin
  DragState.Destroy;
  EllpCreateState.Destroy;
  inherited Destroy;
end;

{ TFigureCreateState }

procedure TFigureCreateState.MouseDwn(x, y: integer);
begin
  CreateFigure(x,y);
  Scene.SetFigure(Figure);
  if DragState <> nil then
    TDragState(DragState).SetFigure(Figure);
  Figure := nil;
  OwnerState.SetActiveState(DragState);
end;

procedure TFigureCreateState.SetDragSt(DragState: TState);
begin
  self.DragState := DragState;
end;

{ TRectCreateState }

procedure TRectCreateState.CreateFigure(x, y: integer);
begin
  Figure := TRectFigure.Create(x,y,x,y);
end;

{ TLineCreateState }

procedure TLineCreateState.CreateFigure(x, y: integer);
begin
  Figure := TLineFigure.Create(x,y,x,y);
end;

{ TEllpCreateState }

procedure TEllpCreateState.CreateFigure(x, y: integer);
begin
  Figure := TEllpFigure.Create(x,y,x,y);
end;

{ TRootState }

procedure TRootState.ChooseActiveState(sState: TStates);
begin
  case sState of
    sEmpty : ActiveState := EmptyState;
    sRect  : ActiveState := RectState;
    sLine  : ActiveState := LineState;
    sEllp  : ActiveState := EllpState;
    sPen   : ActiveState := PenState;
    sSpray : ActiveState := SprayState;
    sEras  : ActiveState := ErasState;
    sFill  : ActiveState := FillState;
  end;
end;

constructor TRootState.Create(Scene : TScene);
begin
  inherited Create(Scene);
  EmptyState := TState.Create(Scene);
  RectState  := TRectState.Create(Scene);
  LineState  := TLineState.Create(Scene);
  EllpState  := TEllpState.Create(Scene);
  PenState   := TPenState.Create(Scene);
  SprayState := TSprayState.Create(Scene);
  ErasState  := TErasState.Create(Scene);
  FillState  := TFillState.Create(Scene);
end;

destructor TRootState.Destroy;
begin
  EmptyState.Destroy;
  RectState.Destroy;
  LineState.Destroy;
  EllpState.Destroy;
  PenState.Destroy;
  SprayState.Destroy;
  ErasState.Destroy;
  FillState.Destroy;
  inherited Destroy;
end;

{ TPenCreateState }

procedure TPenCreateState.CreateFigure(x, y: integer);
begin
  Figure := TPenFigure.Create(x,y,x,y);
end;

{ TPenState }

constructor TPenState.Create(Scene: TScene);
begin
  inherited Create(Scene);
  PenCreateState := TPenCreateState.Create(Scene, self);
  DragState := TDragState.Create(Scene, self, PenCreateState);
  PenCreateState.SetDragSt(DragState);
  ActiveState := PenCreateState;
end;

destructor TPenState.Destroy;
begin
  DragState.Destroy;
  PenCreateState.Destroy;
  inherited Destroy;
end;

{ TDragSprayState }

procedure TDragSprayState.MouseDwn(x, y: integer);
begin
  Scene.Draw;
end;

{ TSprayState }

constructor TSprayState.Create(Scene: TScene);
begin
  inherited Create(Scene);
  SprayCreateState := TSprayCreateState.Create(Scene, self);
  DragSprayState := TDragSprayState.Create(Scene, self, SprayCreateState);
  SprayCreateState.SetDragSt(DragSprayState);
  ActiveState := SprayCreateState;
end;

destructor TSprayState.Destroy;
begin
  DragSprayState.Destroy;
  SprayCreateState.Destroy;
  inherited Destroy;
end;

{ TSprayCreateState }

procedure TSprayCreateState.CreateFigure(x, y: integer);
begin
  Figure := TSprayFigure.Create(x,y);
end;

{ TErasCreateState }

procedure TErasCreateState.CreateFigure(x, y: integer);
begin
  Figure := TErasFigure.Create(x,y,x,y);
end;

{ TErasState }

constructor TErasState.Create(Scene: TScene);
begin
  inherited Create(Scene);
  ErasCreateState := TErasCreateState.Create(Scene, self);
  DragState := TDragState.Create(Scene, self, ErasCreateState);
  ErasCreateState.SetDragSt(DragState);
  ActiveState := ErasCreateState;
end;

destructor TErasState.Destroy;
begin
  DragState.Destroy;
  ErasCreateState.Destroy;
  inherited Destroy;
end;

{ TFillState }

constructor TFillState.Create(Scene: TScene);
begin
  inherited Create(Scene);
  Figure := TFillFigure.Create(0,0);
 // ActiveState := FillCreateState;
end;

procedure TFillState.MouseUp(x, y: integer);
begin    { ???.????(?,?), ??? - ??, ??.???, ???=???}
  Figure.Drag(x,y);
  Scene.SetFigure(Figure);
  Scene.Draw;
  Scene.SetFigure(nil);
  {Painter.Fill(x,y); }
end;

end.
