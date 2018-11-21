local c;
local player = Var "Player";
local ShowComboAt = THEME:GetMetric("Combo", "ShowComboAt");
local Pulse = function(self, param)
	self:zoom(param.Zoom+0.2)
	self:linear(0.15)
	self:zoom(param.Zoom)
end;

local PulseNormal = function(self, param)
	self:zoom(1.2)
	self:linear(0.15)
	self:zoom(1)
end;

local NumberMinZoom = 0.5
local NumberMaxZoom = 1
local NumberMaxZoomAt = 1000

local t = Def.ActorFrame {
	InitCommand=cmd(vertalign,bottom);
	
	LoadFont( "Combo", "numbers" ) .. {
		Name="Number";
		OnCommand=function(self)
			self:xy(0,-15):halign(1)
		end;
	};
	LoadActor("label") .. {
		Name="Label";
		OnCommand = function(self)
			self:x(0):halign(0)
		end;
	};

	InitCommand = function(self)
		c = self:GetChildren();
		c.Number:visible(false);
		c.Label:visible(false);
	end;

	ComboCommand=function(self, param)
		local iCombo = param.Combo;
		if not iCombo or iCombo < ShowComboAt then
			c.Number:visible(false);
			c.Label:visible(false);
			return;
		end

		c.Label:visible(false);

		param.Zoom = scale( iCombo, 0, NumberMaxZoomAt, NumberMinZoom, NumberMaxZoom );
		param.Zoom = clamp( param.Zoom, NumberMinZoom, NumberMaxZoom );
		
		c.Number:visible(true);
		c.Label:visible(true);
		c.Number:settext( string.format("%i", iCombo) );
		-- FullCombo Rewards
		if param.Combo then
			c.Number:diffuse(Color("White"));
			c.Number:stopeffect();
			c.Label:stopeffect();
			(cmd(diffuse,Color("White");))(c.Label);
		else
			c.Number:diffuse(color("#ff0000"));
			c.Label:visible(false);
			c.Number:stopeffect();
			c.Label:stopeffect();
		end

		c.Number:finishtweening();
		c.Label:finishtweening();
		-- Pulse
		Pulse( c.Number, param );
		PulseNormal( c.Label, param );
	end;
};

return t;
