class SocialMediaDetail < ApplicationRecord
    has_many :twitters
    has_many :facebooks
    
    # def get_result
    #     twitters=SocialMediaDetail.get_social_media_info("twitter")
    #     facebooks=SocialMediaDetail.get_social_media_info("facebook")
    #     while(twitters.empty?)do
    #         twitters = get_social_media_info("twitter")
    #     end
    #     while(facebooks.empty?)do
    #         facebooks = get_social_media_info("facebook")
    #     end
    #     self.twitters =twitters
    #     self.facebooks = facebooks

    #     return self

    # end


    # def self.get_social_media_info(type)
    #     uri = URI("https://takehome.io/#{type}")
    #     response = Net::HTTP.get_response(uri)
    #     elements = []
    #     if(response.is_a?(Net::HTTPSuccess))
    #        if(response.body[0]=="[")
    #             result = JSON.parse(response.body) 
    #             if(type=="twitter")
    #                 for ele in result do
    #                     elements.push(Twitter.create(tweet: ele["tweet"]))
    #                 end
    #             else
    #                 for ele in result do
    #                     elements.push(Facebook.create(status: ele["status"]))
    #                 end
    #             end
                
    #        end
    #     end
    #     return elements
    # end
end
