package com.serviceImpl;

import com.dao.BlogTagDao;
import com.entity.BlogTag;
import com.service.BlogTagService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by ldb on 2016/9/22.
 */
@Service("blogTagService")
public class BlogTagServiceImpl implements BlogTagService {

    @Resource
    private BlogTagDao blogTagDao;

    @Override
    public List<BlogTag> findBlogTagList() {
        return blogTagDao.findBlogTagList();
    }

	@Override
	public int saveBlogTag(BlogTag blogTag) {
		return blogTagDao.saveBlogTag(blogTag);
	}

	@Override
	public int updateBlogTag(BlogTag blogTag) {
		return blogTagDao.updateBlogTag(blogTag);
	}

	@Override
	public int deleteBlogTag(Integer id) {
		return blogTagDao.deleteBlogTag(id);
	}

	@Override
	public List<BlogTag> findBlogTagComboListByTypeId(Integer typeId) {
		return blogTagDao.findBlogTagComboListByTypeId(typeId);
	}
}
