package com.serviceImpl;

import com.dao.BlogerDao;
import com.entity.Bloger;
import com.service.BlogerService;
import org.springframework.stereotype.Service;

import java.util.Map;

import javax.annotation.Resource;

/**
 * Created by ldb on 2016/9/22.
 */
@Service("blogerService")
public class BlogerServiceImpl implements BlogerService {

    @Resource
    private BlogerDao blogerDao;

    @Override
    public Bloger getBloger() {
        return blogerDao.getBloger();
    }

	@Override
	public Bloger login(Map<String, Object> map) {
		return blogerDao.login(map);
	}

	@Override
	public int updatePassword(Map<String, Object> map) {
		return blogerDao.updatePassword(map);
	}

	@Override
	public int updateBlogerInfo(Bloger bloger) {
		return blogerDao.updateBlogerInfo(bloger);
	}

	@Override
	public int updateWebClick() {
		return blogerDao.updateWebClick();
	}
}
