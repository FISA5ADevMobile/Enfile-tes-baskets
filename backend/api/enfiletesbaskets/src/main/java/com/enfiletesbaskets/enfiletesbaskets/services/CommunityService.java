package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.repositories.CommunityRepository;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

@Service
public class CommunityService {
    @Resource
    private CommunityRepository communityRepository;
}
