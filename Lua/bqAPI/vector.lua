local Vector = {}
Vector.__index = Vector

-- Constructor: Vector() or Vector(X, Y, Z)
setmetatable(Vector, {
    __call = function(_, X, Y, Z)
        return setmetatable({
            X = X or 0,
            Y = Y or 0,
            Z = Z or 0
        }, Vector)
    end
})

-- operator

function Vector.__add(a, b)
    return Vector(a.X + b.X, a.Y + b.Y, a.Z + b.Z)
end

function Vector.__sub(a, b)
    return Vector(a.X - b.X, a.Y - b.Y, a.Z - b.Z)
end

-- Multiplication supports: vector * scalar OR vector * vector
function Vector.__mul(a, b)
    if type(a) == "number" then
        return Vector(a * b.X, a * b.Y, a * b.Z)
    elseif type(b) == "number" then
        return Vector(a.X * b, a.Y * b, a.Z * b)
    else
        return Vector(a.X * b.X, a.Y * b.Y, a.Z * b.Z)
    end
end

-- Division by scalar
function Vector.__div(a, b)
    return Vector(a.X / b, a.Y / b, a.Z / b)
end

-- Unary - (negation)
function Vector.__unm(a)
    return Vector(-a.X, -a.Y, -a.Z)
end

-- Pretty printing
function Vector.__tostring(a)
    return string.format("Vector(%.3f, %.3f, %.3f)", a.X, a.Y, a.Z)
end

-- self methods

function Vector:length()
    return math.sqrt(self.X * self.X + self.Y * self.Y + self.Z * self.Z)
end

function Vector:normalize()
    local len = self:length()
    if len == 0 then
        return Vector(0, 0, 0)
    end
    return self / len
end

function Vector:dot(b)
    return self.X * b.X + self.Y * b.Y + self.Z * b.Z
end

function Vector:cross(b)
    return Vector(
        self.Y * b.Z - self.Z * b.Y,
        self.Z * b.X - self.X * b.Z,
        self.X * b.Y - self.Y * b.X
    )
end

_G.Vector = Vector

print("RUNNING VECTROR VECTRORVECTRORVECTRORVECTRORVECTRORVECTROR")