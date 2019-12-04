package tools;

import org.ansj.domain.Result;
import org.ansj.domain.Term;
import org.ansj.splitWord.analysis.ToAnalysis;

import java.util.*;

public class StringTools {
	public static String[] Cut(String str)
	{
		Result result=ToAnalysis.parse(str);
		List<Term> t=result.getTerms();
		
		String[] strs=new String[t.size()];
		for(int i=0;i<t.size();i++)
		{
			strs[i]=t.get(i).getName();
			System.out.println(strs[i] + " ");
			}
		return strs;
	}
}