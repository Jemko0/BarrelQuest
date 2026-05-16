#pragma once

template<typename TKey, typename TValue>
struct TReplicatedMap
{
    TArray<TKey>& Keys;
    TArray<TValue>& Values;
    TMap<TKey, int32> LookupIndex;
    
    TReplicatedMap(TArray<TKey>& Keys, TArray<TValue>& Values)
        : Keys(Keys), Values(Values) {}

    void RebuildIndex()
    {
        LookupIndex.Empty();
        LookupIndex.Reserve(Keys.Num());
        for (int32 i = 0; i < Keys.Num(); i++)
            LookupIndex.Add(Keys[i], i);
    }
    
    struct FPair
    {
        const TKey& Key;
        TValue& Value;
    };
    
    struct FIterator
    {
        TReplicatedMap& Map;
        int32 Idx;
        
        FIterator(TReplicatedMap& Map, int32 Idx) : Map(Map), Idx(Idx) {}
        
        FPair operator*() { return FPair(Map.Keys[Idx], Map.Values[Idx]); }
        FIterator& operator++() { ++Idx; return *this; }
        FIterator& operator--() { --Idx; return *this; }
        bool operator!=(const FIterator& other) const { return Idx != other.Idx; }
    };
    
    FIterator begin() { return FIterator(*this, 0); }
    FIterator end() { return FIterator(*this, Keys.Num()); }
    
    TValue& Add(const TKey& Key, const TValue& Value)
    {
        int32* Existing = LookupIndex.Find(Key);
        if (Existing)
        {
            Values[*Existing] = Value;
            return Values[*Existing];
        }

        int32 NewIdx = Keys.Num();
        Keys.Add(Key);
        Values.Add(Value);
        LookupIndex.Add(Key, NewIdx);
        return Values[NewIdx];
    }
    
    TValue* Find(const TKey& Key)
    {
        int32* Idx = LookupIndex.Find(Key);
        if (Idx)
            return &Values[*Idx];
        return nullptr;
    }
    
    const TValue* Find(const TKey& Key) const
    {
        const int32* Idx = LookupIndex.Find(Key);
        if (Idx)
            return &Values[*Idx];
        return nullptr;
    }
    
    void Remove(const TKey& Key)
    {
        int32* Idx = LookupIndex.Find(Key);
        if (!Idx) return;

        int32 RemoveIdx = *Idx;
        LookupIndex.Remove(Key);

        if (RemoveIdx != Keys.Num() - 1)
            LookupIndex[Keys.Last()] = RemoveIdx;

        Keys.RemoveAtSwap(RemoveIdx);
        Values.RemoveAtSwap(RemoveIdx);
    }
    
    void Empty()
    {
        Keys.Empty();
        Values.Empty();
        LookupIndex.Empty();
    }
    
    bool Contains(const TKey& Key) const
    {
        return LookupIndex.Contains(Key);
    }
    
    int32 Num() const { return Keys.Num(); }
    
    TValue& operator[](const TKey& Key)
    {
        int32* Idx = LookupIndex.Find(Key);
        if (Idx)
            return Values[*Idx];

        int32 NewIdx = Keys.Num();
        Keys.Add(Key);
        Values.AddDefaulted();
        LookupIndex.Add(Key, NewIdx);
        return Values[NewIdx];
    }
    
    const TValue& operator[](const TKey& Key) const
    {
        const int32* Idx = LookupIndex.Find(Key);
        check(Idx != nullptr);
        return Values[*Idx];
    }
};
