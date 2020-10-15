package com.wcc.lucene;

import com.wcc.pojo.Blog;
import com.wcc.service.BlogService;
import com.wcc.service.impl.BlogServiceImpl;
import com.wcc.util.DateUtil;
import com.wcc.util.StringUtil;
import org.apache.commons.lang.StringEscapeUtils;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.cn.smart.SmartChineseAnalyzer;
import org.apache.lucene.document.*;
import org.apache.lucene.index.*;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.*;
import org.apache.lucene.search.highlight.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;

import javax.annotation.Resource;
import java.io.IOException;
import java.io.StringReader;
import java.nio.file.Paths;
import java.util.LinkedList;
import java.util.List;

/**
 * BlogIndex:【blog-使用lucene对博客进行增删改查】
 *
 * @author: WuChen
 * @create: 2020-10-12 22:42
 * @modify:
 */
public class BlogIndex {

    /**
     *
     */
    private Directory dir = null;

    /**
     * 目录
     */
    private String lucenePath = "c://lucene";

    /**
     * 获取对lucene的写入方法
     *
     * @return
     * @throws Exception
     */
    private IndexWriter getWriter() throws Exception {
        dir = FSDirectory.open(Paths.get(lucenePath, new String[0]));
        SmartChineseAnalyzer analyzer = new SmartChineseAnalyzer();
        IndexWriterConfig iwc = new IndexWriterConfig(analyzer);
        IndexWriter writer = new IndexWriter(dir, iwc);
        return writer;
    }

    /**
     * 增加索引
     *
     * @param blog 博客对象
     * @throws Exception
     */
    public void addIndex(Blog blog) throws Exception {
        IndexWriter writer = getWriter();
        Document doc = new Document();
        doc.add(new StringField("id", String.valueOf(blog.getId()), Field.Store.YES));
        doc.add(new TextField("title", blog.getTitle(), Field.Store.YES));
        doc.add(new TextField("content", blog.getContent(), Field.Store.YES));
        doc.add(new TextField("summary", blog.getSummary(), Field.Store.YES));
        doc.add(new TextField("keyWord", blog.getKeyWord(), Field.Store.YES));
        writer.addDocument(doc);
        writer.close();
    }

    /**
     * 更新索引
     *
     * @param blog 博客对象
     * @throws Exception
     */
    public void updateIndex(Blog blog) throws Exception {
        IndexWriter writer = getWriter();
        Document doc = new Document();
        doc.add(new StringField("id", String.valueOf(blog.getId()), Field.Store.YES));
        doc.add(new TextField("title", blog.getTitle(), Field.Store.YES));
        doc.add(new TextField("content", blog.getContent(), Field.Store.YES));
        doc.add(new TextField("summary", blog.getSummary(), Field.Store.YES));
        doc.add(new TextField("keyWord", blog.getKeyWord(), Field.Store.YES));
        writer.updateDocument(new Term("id", String.valueOf(blog.getId())), doc);
        writer.close();
    }

    /**
     * 删除索引
     *
     * @param blogId 被删除索引的ID
     * @throws Exception
     */
    public void deleteIndex(String blogId) throws Exception {
        IndexWriter writer = getWriter();
        writer.deleteDocuments(new Term[]{new Term("id", blogId)});
        writer.forceMergeDeletes();
        writer.commit();
        writer.close();
    }

    /**
     * 搜索索引
     *
     * @param q 搜索条件
     * @return
     * @throws Exception
     */
    public List<Blog> searchBlog(String q, BlogService blogService) throws Exception {
        List<Blog> blogList = new LinkedList<>();
        dir = FSDirectory.open(Paths.get(lucenePath, new String[0]));
        //获取Reader
        IndexReader reader = DirectoryReader.open(dir);
        //获取流
        IndexSearcher is = new IndexSearcher(reader);
        //放入查询条件
        BooleanQuery.Builder booleanQuery = new BooleanQuery.Builder();
        SmartChineseAnalyzer analyzer = new SmartChineseAnalyzer();
        QueryParser parser = new QueryParser("title", analyzer);
        Query query = parser.parse(q);
        QueryParser parser2 = new QueryParser("content", analyzer);
        Query query2 = parser.parse(q);
        QueryParser parser3 = new QueryParser("keyWord", analyzer);
        Query query3 = parser.parse(q);

        booleanQuery.add(query, BooleanClause.Occur.SHOULD);
        booleanQuery.add(query2, BooleanClause.Occur.SHOULD);
        booleanQuery.add(query3, BooleanClause.Occur.SHOULD);

        //最多返回100条数据
        TopDocs hits = is.search(booleanQuery.build(), 100);

        //高亮搜索字
        QueryScorer scorer = new QueryScorer(query);
        Fragmenter fragmenter = new SimpleSpanFragmenter(scorer);
        SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter("<b><font color='red'>", "</font></b>");
        Highlighter highlighter = new Highlighter(simpleHTMLFormatter, scorer);
        highlighter.setTextFragmenter(fragmenter);

        //遍历查询结果放入集合中
        for (ScoreDoc scoreDoc : hits.scoreDocs) {
            Document doc = is.doc(scoreDoc.doc);
            Blog blog = blogService.selBlogById(Integer.parseInt(doc.get("id")));
            String title = doc.get("title");
            String content = StringEscapeUtils.escapeHtml(doc.get("content"));
            String summary = StringEscapeUtils.escapeHtml(doc.get("summary"));
            String keyWord = doc.get("keyWord");
            if (title != null) {
                TokenStream tokenStream = analyzer.tokenStream("title", new StringReader(title));
                String hitTitle = highlighter.getBestFragment(tokenStream, title);
                if (StringUtil.isEmpty(hitTitle)) {
                    blog.setTitle(title);
                } else {
                    blog.setTitle(hitTitle);
                }
            }
            if (content != null) {
                TokenStream tokenStream = analyzer.tokenStream("content", new StringReader(content));
                String hitContent = highlighter.getBestFragment(tokenStream, content);
                if (StringUtil.isEmpty(hitContent)) {
                    if (content.length() <= 200)
                        blog.setContent(content);
                    else
                        blog.setContent(content.substring(0, 200));
                } else {
                    blog.setContent(hitContent);
                }
            }
            if (summary != null) {
                TokenStream tokenStream = analyzer.tokenStream("summary", new StringReader(summary));
                String hitSummary = highlighter.getBestFragment(tokenStream, summary);
                if (StringUtil.isEmpty(hitSummary)) {
                    blog.setSummary(summary);
                } else {
                    blog.setSummary(hitSummary);
                }
            }
            if (keyWord != null) {
                TokenStream tokenStream = analyzer.tokenStream("keyWord", new StringReader(keyWord));
                String hitKeyWord = highlighter.getBestFragment(tokenStream, keyWord);
                if (StringUtil.isEmpty(hitKeyWord)) {
                    blog.setKeyWord(keyWord);
                } else {
                    blog.setKeyWord(hitKeyWord);
                }
            }
            blogList.add(blog);
        }
        return blogList;
    }
}
