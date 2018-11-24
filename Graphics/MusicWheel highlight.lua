local t = Def.ActorFrame{
	Def.Quad{
		OnCommand=function(self)
			--self:scaletoclipped(256,80)
			self:rotationz(-45):zoom(.7):xy(30,-30)
		end;
	};
};

return t;