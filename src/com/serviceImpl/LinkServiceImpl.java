package com.serviceImpl;

import com.dao.LinkDao;
import com.entity.Link;
import com.service.LinkService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by ldb on 2016/9/22.
 */
@Service("linkService")
public class LinkServiceImpl implements LinkService {

    @Resource
    private LinkDao linkDao;

    @Override
    public List<Link> findLinkList() {
        return linkDao.findLinkList();
    }

	@Override
	public int saveLink(Link link) {
		return linkDao.saveLink(link);
	}

	@Override
	public int updateLink(Link link) {
		return linkDao.updateLink(link);
	}

	@Override
	public int deleteLink(Integer id) {
		return linkDao.deleteLink(id);
	}
}
