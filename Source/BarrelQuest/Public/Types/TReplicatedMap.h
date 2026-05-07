#pragma once

template<typename TKey, typename TValue>
struct TReplicatedMap
{
	TArray<TKey>& Keys;
	TArray<TValue>& Values;
	
	TReplicatedMap(TArray<TKey>& Keys, TArray<TValue>& Values)
		: Keys(Keys), Values(Values) {}
	
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
		
		FPair operator*() {return FPair(Map.Keys[Idx], Map.Values[Idx]);}
		FIterator& operator++() {++Idx; return *this;}
		FIterator& operator--() {--Idx; return *this;}
		bool operator!=(const FIterator& other) const {return Idx != other.Idx;}
	};
	
	FIterator begin() {return FIterator(*this, 0);}
	FIterator end() {return FIterator(*this, Keys.Num());}
	
	TValue& Add(const TKey& key, const TValue& value)
	{
		int32 idx = Keys.IndexOfByKey(key);
		if (idx != INDEX_NONE)
		{
			Values[idx] = value;
			return Values[idx];
		}
		else
		{
			Keys.Add(key);
			int32 AddedIndex = Values.Add(value);
			return Values[AddedIndex];
		}
	}
	
	TValue* Find(const TKey& Key)
	{
		int32 idx = Keys.IndexOfByKey(Key);
		if (idx != INDEX_NONE)
			return &Values[idx];
		return nullptr;
	}
	
	const TValue* Find(const TKey& Key) const
	{
		int32 idx = Keys.IndexOfByKey(Key);
		if (idx != INDEX_NONE)
			return &Values[idx];
		return nullptr;
	}
	
	void Remove(const TKey& key)
	{
		int32 idx = Keys.IndexOfByKey(key);
		if (idx != INDEX_NONE)
		{
			Keys.RemoveAtSwap(idx);
			Values.RemoveAtSwap(idx);
		}
	}
	
	void Empty()
	{
		Keys.Empty();
		Values.Empty();
	}
	
	bool Contains(const TKey& key) const
	{
		return Keys.Contains(key);
	}
	
	int32 Num() const { return Keys.Num(); }
	
	TValue& operator[](const TKey& key)
	{
		int32 idx = Keys.IndexOfByKey(key);
		if (idx != INDEX_NONE)
		{
			return Values[idx];
		}
		
		Keys.Add(key);
		return Values.AddDefaulted_GetRef();
	}
	
	const TValue& operator[](const TKey& key) const
	{
		int32 idx = Keys.IndexOfByKey(key);
		check(idx != INDEX_NONE);
		return Values[idx];
	}
};
