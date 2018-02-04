module Frontend.LLVM where

import Data.Map as Map
import Data.Sequence as Seq
import Data.List as List

newtype UniqueId = UniqueId String
    deriving (Eq, Ord, Show)

data Label = Entry | Label Integer UniqueId
    deriving (Eq, Ord, Show)

newtype Ident = Ident String
    deriving (Eq, Ord)

data FunctionAddr = FunctionAddr Ident Type
    deriving (Eq, Ord)

data Register = Register UniqueId Type 
    deriving (Eq, Ord)

data Global = GlobalString Ident Type String
    deriving (Eq, Ord)

data Operand 
    = Reg Register 
    | Glob Global
    | ConstBool Bool
    | ConstInt Integer
    | Null
    deriving (Eq, Ord)

data Type = Size1 | Size8 | Size32 | Ptr Type | Arr Integer Type | Void | TypeClass UniqueId
    deriving (Eq, Ord)

data Phi = Phi Register [PhiBranch] 
    deriving Eq

data PhiBranch = PhiBranch Label Operand 
    deriving Eq
    
data Block = Block {
    _blockLabel :: Label,
    _blockPhi :: Seq.Seq Phi,
    _blockBody :: Seq.Seq Instruction,
    _blockEnd :: BlockEnd
} deriving Eq

data BlockEnd
    = BlockEndBranch Label
    | BlockEndBranchCond Operand Label Label
    | BlockEndReturn Operand
    | BlockEndReturnVoid
    | BlockEndNone
    deriving Eq

data Alloc = Alloc Register
    deriving Eq

data Instruction
    = InstrBinOp Register Op Operand Operand
    | InstrCall Register FunctionAddr [Operand]
    | InstrVoidCall FunctionAddr [Operand]
    | InstrGetElementPtr Register Operand [(Type, Idx)]
    | InstrCmp Register Cond Operand Operand
    | InstrBitcast Register Operand
    | InstrLoad Register Register
    | InstrStore Operand Register
    deriving Eq

data Idx = IdxConst Integer | IdxAddr UniqueId
    deriving (Eq, Show)

data FunctionDef = FunctionDef {
    _functionAddr :: FunctionAddr,
    _functionArgs :: Seq.Seq Register,
    _localVars :: Seq.Seq Alloc,
    _blocks :: Map.Map Label Block
}

data ClassDef = ClassDef {
    _classIdent :: UniqueId,
    _fieldTypes :: Seq.Seq Type
}

data Program = Program {
    _programStrings :: [Global],
    _classDefs :: Seq.Seq ClassDef,
    _functionDefs :: Seq.Seq FunctionDef
}

data Op
    = Plus
    | Minus
    | Times
    | Div
    | Mod
    deriving Eq

data Cond
    = LTH
    | LE
    | GTH
    | GE
    | EQU
    | NE
    deriving Eq