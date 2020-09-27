package com.wcc.service.impl;

import com.wcc.mapper.LinkMapper;
import com.wcc.pojo.Link;
import com.wcc.service.LinkService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * LinkServiceImpl:【blog-友情链接业务层实现类】
 *
 * @author: WuChen
 * @create: 2020-09-26 17:53
 * @modify:
 */
@Service("linkService")
public class LinkServiceImpl implements LinkService {

    @Resource
    private LinkMapper linkMapper;

    @Override
    public int insLink(Link link) {
        return linkMapper.insLink(link);
    }

    @Override
    public int updLink(Link link) {
        return linkMapper.updLink(link);
    }

    @Override
    public int delLink(Integer id) {
        return linkMapper.delLink(id);
    }

    @Override
    public List<Link> getAllLink() {
        return linkMapper.getAllLink();
    }

    @Override
    public Link selLinkById(Integer id) {
        return linkMapper.selLinkById(id);
    }

    @Override
    public List<Link> selLinkByMap(Map<String, Object> map) {
        return linkMapper.selLinkByMap(map);
    }

    @Override
    public long selLinkCountByMap(Map<String, Object> map) {
        return linkMapper.selLinkCountByMap(map);
    }
}
